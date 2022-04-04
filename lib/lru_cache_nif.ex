defmodule LruCacheNif do
    @moduledoc """
    Documentation for `LruCacheNif`.
    An LRU Cache implemented in native using Rustler
    """

    use Rustler, otp_app: :lru_cache_nif, crate: :lru_cache_nif

    @doc """
    Creates a new LRU Cache that holds at most 'capacity' items.

    ## Examples

        iex> LruCacheNif.new(5)
        {:ok, #Reference<0.2676741554.1688338436.467>}

    """
    def new(_capacity), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Puts a key-value pair into cache.
    If the key already exists in the cache, then it updates the key’s value and returns nil.
    Otherwise, if the cache is full, remove and return the least recently used {k,v}.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.put(cache, 3, :c)
        {:ok, nil}
        iex> LruCacheNif.put(cache, 4, {:d})
        {:ok, {1, "a"}}
    """
    def put(_cache, _k, _v), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a reference to the value of the key in the cache
        or {:error, :not_found} if it is not present in the cache.
    Moves the key to the head of the LRU list if it exists.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.get(cache, 1)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.get(cache, 1)
        {:ok, "a"}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, {2, 'b'}}
    """
    def get(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a reference to the value corresponding to the key in the cache
        or {:error, :not_found} if it is not present in the cache.
    Unlike get, peek does not update the LRU list so the key’s position will be unchanged.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.peek(cache, 1)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.peek(cache, 1)
        {:ok, "a"}
    """
    def peek(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the value corresponding to the least recently used item
        or {:error, :not_found} if the cache is empty.
    Like peek, peek_lru does not update the LRU list so the item’s position will be unchanged.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.peek_lru(cache)
        {:error, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.peek_lru(cache)
        {:ok, {1, "a"}}
    """
    def peek_lru(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a bool indicating whether the given key is in the cache. Does not update the LRU list.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.contains(cache, 1)
        {:ok, false}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.contains(cache, 1)
        {:ok, true}
    """
    def contains(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Removes and returns the value corresponding to the key from the cache
        or {:error, :not_found} if it does not exist.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.pop(cache, 1)
        {:ok, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.pop(cache, 1)
        {:ok, "a"}
        iex> LruCacheNif.pop(cache, 1)
        {:ok, :not_found}
    """
    def pop(_cache, _k), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Removes and returns the key and value corresponding to the least recently used item
        or {:error, :not_found} if the cache is empty.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, :not_found}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, {1, "a"}}
        iex> LruCacheNif.pop_lru(cache)
        {:ok, {2, 'b'}}
    """
    def pop_lru(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the number of key-value pairs that are currently in the the cache.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.len(cache)
        {:ok, 0}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.len(cache)
        {:ok, 2}
    """
    def len(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns a bool indicating whether the cache is empty or not.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.is_empty(cache)
        {:ok, true}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.is_empty(cache)
        {:ok, false}
    """
    def is_empty(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Returns the maximum number of key-value pairs the cache can hold.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.cap(cache)
        {:ok, 3}
    """
    def cap(_cache), do: :erlang.nif_error(:nif_not_loaded)


#    @doc """
#    Resizes the cache.
#    If the new capacity is smaller than the size of the current cache any entries past the new capacity are discarded.
#    """
#    def resize(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Clears the contents of the cache.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.len(cache)
        {:ok, 2}
        iex> LruCacheNif.clear(cache)
        {:ok, :ok}
        iex> LruCacheNif.len(cache)
        {:ok, 0}
    """
    def clear(_cache), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all keys in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.keys(cache)
        {:ok, [2, 1]}
    """
    def keys(_caches), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all values in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.values(cache)
        {:ok, ['b', "a"]}
    """
    def values(_caches), do: :erlang.nif_error(:nif_not_loaded)

    @doc """
    Get all key-value tuples in mostly-recently used order.

    ## Examples

        iex> {:ok, cache} = LruCacheNif.new(3)
        {:ok, #Reference<0.2676741554.1688338436.467>}
        iex> LruCacheNif.put(cache, 1, "a")
        {:ok, nil}
        iex> LruCacheNif.put(cache, 2, 'b')
        {:ok, nil}
        iex> LruCacheNif.to_list(cache)
        {:ok, [{2, 'b'}, {1, "a"}]}
    """
    def to_list(_caches), do: :erlang.nif_error(:nif_not_loaded)
end
