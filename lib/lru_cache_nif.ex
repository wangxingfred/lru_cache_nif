defmodule LruCacheNif do
    @moduledoc """
    Documentation for `LruCacheNif`.
    An LRU Cache implemented in native using Rustler
    """

    use Rustler, otp_app: :lru_cache_nif, crate: :lru_cache_nif

    @type lru_cache :: reference()

    @type common_errors ::
              {:error, :bad_reference} | {:error, :lock_fail} | {:error, :unsupported_type}

    @typedoc """
    Only a subset of Elixir types are supported by the nif, the semantic type `supported_term` can
    be used as a shorthand for terms of these supported types.
    """
    @type supported_term :: integer() | atom() | tuple() | list() | String.t()

    @type key :: supported_term
    @type value :: supported_term

    @doc """
    Creates a new LRU Cache that holds at most 'capacity' items.

    ## Examples

        iex> {:ok, _cache} = LruCacheNif.new(5)

    """
    @spec new(capacity :: pos_integer()) :: {:ok, lru_cache()}
    def new(_capacity), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Creates a new LRU Cache that holds at most 'capacity' items.

    ## Examples

        iex> {:ok, _cache} = LruCacheNif.from_keys(5, [1,2,3,4,5], true)

    """
    @spec from_keys(capacity :: pos_integer(), keys :: [key], v :: value) :: {:ok, lru_cache()}
    def from_keys(_capacity, _keys, _v), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Creates a new LRU Cache that holds at most 'capacity' items.

    ## Examples

        iex> {:ok, _cache} = LruCacheNif.from_list(5, [{1,100}, {2,200}, {3,300}, {4,400}, {5,500}])

    """
    @spec from_list(capacity :: pos_integer(), kv_list :: [{key, value}]) :: {:ok, lru_cache()}
    def from_list(_capacity, _kv_list), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Puts a key-value pair into cache.
    If the key already exists in the cache, then it updates the key’s value and returns nil.
    Otherwise, if the cache is full, remove and return the least recently used {k,v}.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.put(cache, 3, :c)
        {:ok, nil}
        iex> LruCacheNif.put(cache, 4, {:d})
        {:ok, {1, "a"}}
    """
    @spec put(cache :: lru_cache, k :: key, v :: value) :: {:ok, nil | {key, value}} | common_errors
    def put(_cache, _k, _v), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a reference to the value of the key in the cache
        or {:error, :not_found} if it is not present in the cache.
    Moves the key to the head of the LRU list if it exists.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.get(cache, 1)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.get(cache, 1)
        {:ok, "a"}
    """
    @spec get(cache :: lru_cache, k :: key) :: {:ok, nil | value} | common_errors
    def get(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a reference to the value corresponding to the key in the cache
        or {:error, :not_found} if it is not present in the cache.
    Unlike get, peek does not update the LRU list so the key’s position will be unchanged.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.peek(cache, 1)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.peek(cache, 1)
        {:ok, "a"}
    """
    @spec peek(cache :: lru_cache, k :: key) :: {:ok, nil | value} | common_errors
    def peek(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the value corresponding to the least recently used item
        or {:error, :empty} if the cache is empty.
    Like peek, peek_lru does not update the LRU list so the item’s position will be unchanged.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.peek_lru(cache)
        {:error, :empty}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.peek_lru(cache)
        {:ok, {1, "a"}}
    """
    @spec peek_lru(cache :: lru_cache) :: {:ok, {key, value}} | {:error, :empty} | common_errors
    def peek_lru(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a bool indicating whether the given key is in the cache. Does not update the LRU list.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.contains(cache, 1)
        {:ok, false}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.contains(cache, 1)
        {:ok, true}
    """
    @spec contains(cache :: lru_cache, k :: key) :: {:ok, boolean} | common_errors
    def contains(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Removes and returns the value corresponding to the key from the cache
        or {:error, :not_found} if it does not exist.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.pop(cache, 1)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.pop(cache, 1)
        {:ok, "a"}
        iex> LruCacheNif.pop(cache, 1)
        {:error, :not_found}
    """
    @spec pop(cache :: lru_cache, k :: key) :: {:ok, value} | common_errors
    def pop(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Removes and returns the key and value corresponding to the least recently used item
        or {:error, :empty} if the cache is empty.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.pop_lru(cache)
        {:error, :empty}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, {1, "a"}}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, {2, 'b'}}
    """
    @spec pop_lru(cache :: lru_cache) :: {:ok, {key, value}} | {:error, :empty} | common_errors
    def pop_lru(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the number of key-value pairs that are currently in the the cache.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.len(cache)
        {:ok, 0}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.len(cache)
        {:ok, 2}
    """
    @spec len(cache:: lru_cache) :: {:ok, non_neg_integer} | common_errors
    def len(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a bool indicating whether the cache is empty or not.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.is_empty(cache)
        {:ok, true}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.is_empty(cache)
        {:ok, false}
    """
    @spec is_empty(cache:: lru_cache) :: {:ok, boolean} | common_errors
    def is_empty(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the maximum number of key-value pairs the cache can hold.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        iex> LruCacheNif.cap(cache)
        {:ok, 3}
    """
    @spec cap(cache:: lru_cache) :: {:ok, non_neg_integer} | common_errors
    def cap(_cache), do: :erlang.nif_error(:nif_not_loaded)


    @doc """
    Resizes the cache.
    If the new capacity is smaller than the size of the current cache,
        any entries past the new capacity are removed and returned as list.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.from_keys(5, [1,2,3,4,5], true)
        iex> LruCacheNif.resize(cache, 3)
        {:ok, [{1,true}, {2,true}]}
    """
    @spec resize(cache:: lru_cache, capacity :: pos_integer()) :: {:ok, [{key,value}]} | common_errors
    def resize(_cache, _capacity), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Clears the contents of the cache.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.from_list(3, [{1,"a"}, {2, 'b'}])
        iex> LruCacheNif.len(cache)
        {:ok, 2}
        iex> LruCacheNif.clear(cache)
        :ok
        iex> LruCacheNif.len(cache)
        {:ok, 0}
    """
    @spec clear(cache:: lru_cache) :: :ok | common_errors
    def clear(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all keys in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.from_list(3, [{1,"a"}, {2, 'b'}])
        iex> LruCacheNif.keys(cache)
        {:ok, [2, 1]}
    """
    @spec keys(cache:: lru_cache) :: {:ok, [key]} | common_errors
    def keys(_caches), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all values in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.from_list(3, [{1,"a"}, {2, 'b'}])
        iex> LruCacheNif.values(cache)
        {:ok, ['b', "a"]}
    """
    @spec values(cache:: lru_cache) :: {:ok, [value]} | common_errors
    def values(_caches), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all key-value tuples in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.from_list(3, [{1,"a"}, {2, 'b'}])
        iex> LruCacheNif.to_list(cache)
        {:ok, [{2, 'b'}, {1, "a"}]}
    """
    @spec to_list(cache:: lru_cache) :: {:ok, [{key, value}]} | common_errors
    def to_list(_caches), do: :erlang.nif_error(:nif_not_loaded)
end
