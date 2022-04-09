add_scenario = fn inputs, capacity ->
    #    cell_size = 500

    prefix =
        capacity
        |> Integer.floor_div(1000)
        |> Integer.to_string(10)
        |> String.pad_leading(4, "0")

    #    padded_size =
    #        size
    #        |> Integer.to_string(10)
    #        |> String.pad_leading(7, " ")

    [:beginning, :middle, :ending]
    |> Enum.with_index(1)
    |> Enum.reduce(
           inputs,
           fn {placement, idx}, inputs ->
               human_placement =
                   placement
                   |> Atom.to_string()
                   |> String.capitalize()

               key = "#{prefix}-#{idx} // #{human_placement}"
               Map.put(inputs, key, {capacity, placement})
           end
       )
end

make_input = fn {capacity, position} ->
    len = 0
#    {:ok, cache} = LruCacheNif.new(capacity)
#    ets = :ets.new(:ets, [])

    item =
        case position do
            :beginning ->
                15000

            :middle ->
                capacity * 5000 + 5000

            :ending ->
                capacity * 10000 + 5000
        end

    %{item: item, len: len, capacity: capacity}
end

lru_put = fn (%{item: item, capacity: capacity} = input, put_count) ->
    {:ok, cache} = LruCacheNif.new(capacity)

    for i <- 1..put_count do
        LruCacheNif.put(cache, item + i, item + i)
    end

    {input, put_count}
end

lru_put_get = fn (%{item: item, capacity: capacity} = input, put_count) ->
    {:ok, cache} = LruCacheNif.new(capacity)

    for i <- 1..put_count do
        LruCacheNif.put(cache, item + i, item + i)
    end

    for i <- 1..put_count do
        LruCacheNif.get(cache, item + i)
    end

    {input, put_count}
end

ets_insert = fn (%{item: item} = input, put_count) ->
    ets = :ets.new(:ets, [])

    for i <- 1..put_count do
        :ets.insert(ets, {item + i, item + i})
    end

    {input, put_count}
end

ets_insert_lookup = fn (%{item: item} = input, put_count) ->
    ets = :ets.new(:ets, [])

    for i <- 1..put_count do
        :ets.insert(ets, {item + i, item + i})
    end

    for i <- 1..put_count do
        :ets.lookup(ets, item + i)
    end

    {input, put_count}
end

map_put = fn (%{item: item} = input, put_count) ->
    map = %{}

    map = for i <- 1..put_count, reduce: map do
        map -> Map.put(map, item + i, item + i)
    end

    {input, put_count}
end

map_put_get = fn (%{item: item} = input, put_count) ->
    map = %{}

    map = for i <- 1..put_count, reduce: map do
        map -> Map.put(map, item + i, item + i)
    end

    x = for i <- 1..put_count, reduce: 0 do
        x -> Map.get(map, item + i)
    end

    {input, put_count}
end

#after_each = fn {%{cache: cache, len: len, capacity: capacity}, put_count} ->
#                 expected = min(len + put_count, capacity)
#                 {:ok, actual} = LruCacheNif.len(cache)
#
#                 if expected != actual do
#                     raise "LruCache len incorrect: expected #{expected} but found #{actual}"
#                 end
#end

jobs = %{
    "LruCacheNif: put 10000" => &(lru_put.(&1, 10000)),
    "LruCacheNif: put&get 10000" => &(lru_put_get.(&1, 10000)),
    "Ets: insert 10000" => &(ets_insert.(&1, 10000)),
    "Ets: insert&lookup 10000" => &(ets_insert_lookup.(&1, 10000)),
    "Map: put 10000" => &(map_put.(&1, 10000)),
    "Map: put&get 10000" => &(map_put_get.(&1, 10000)),
}

input_capacities = [10000]

inputs = for capacity <- input_capacities, reduce: %{} do
    acc -> add_scenario.(acc, capacity)
end

Benchee.run(
    jobs,
    inputs: inputs,
    before_each: make_input,
#    after_each: after_each,
    formatters: [
        {Benchee.Formatters.HTML, file: "bench/results/put/html/put.html"},
        Benchee.Formatters.Console
    ],
    save: %{
        path: "bench/results/put/runs"
    },
    time: 5,
    memory_time: 2,
    reduction_time: 2
)