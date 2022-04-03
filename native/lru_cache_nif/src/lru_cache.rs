use crate::supported_term::SupportedTerm;


pub struct LruCache {
    cache: lru::LruCache<SupportedTerm, SupportedTerm>,
}

impl LruCache {
    pub fn new(cap: usize) -> LruCache {
        LruCache {
            cache: lru::LruCache::new(cap)
        }
    }

    pub fn put(&mut self, k: SupportedTerm, v: SupportedTerm)
               -> Option<(SupportedTerm, SupportedTerm)> {
        if self.cache.contains(&k) {
            self.cache.put(k, v);
            return None;
        }

        if self.cache.len() == self.cache.cap() {
            let removed = self.cache.pop_lru();
            self.cache.put(k, v);
            return removed;
        }

        self.cache.put(k, v);
        return None;
    }

    pub fn get(&mut self, k: &SupportedTerm) -> Option<&SupportedTerm> {
        self.cache.get(k)
    }

    pub fn peek(&self, k: &SupportedTerm) -> Option<&SupportedTerm> {
        self.cache.peek(k)
    }

    pub fn peek_lru<'a>(&self) -> Option<(&'a SupportedTerm, &'a SupportedTerm)> {
        self.cache.peek_lru()
    }

    pub fn contains(&self, k: &SupportedTerm) -> bool {
        self.cache.contains(k)
    }

    pub fn pop(&mut self, k: &SupportedTerm) -> Option<SupportedTerm> {
        self.cache.pop(k)
    }

    pub fn pop_lru(&mut self) -> Option<(SupportedTerm, SupportedTerm)> {
        self.cache.pop_lru()
    }

    pub fn len(&self) -> usize {
        self.cache.len()
    }

    pub fn is_empty(&self) -> bool {
        self.cache.is_empty()
    }

    pub fn cap(&self) -> usize {
        self.cache.cap()
    }

    // pub fn resize(&mut self, cap: usize) {
    //     while self.cache.len() > cap {
    //         self.pop_lru();
    //     }
    //
    //     self.cache.resize(cap);
    // }

    pub fn clear(&mut self) {
        self.cache.clear()
    }

    pub fn keys(&self) -> Vec<SupportedTerm> {
        let mut key_vec = Vec::with_capacity(self.cache.len());
        for (k, _v) in self.cache.iter() {
            key_vec.push(k.clone());
        }
        key_vec
    }

    pub fn values(&self) -> Vec<SupportedTerm> {
        let mut value_vec = Vec::with_capacity(self.cache.len());
        for (_k, v) in self.cache.iter() {
            value_vec.push(v.clone());
        }
        value_vec
    }

    pub fn to_vec(&self) -> Vec<(SupportedTerm, SupportedTerm)> {
        let mut new_vec = Vec::with_capacity(self.cache.len());
        for (k, v) in self.cache.iter() {
            new_vec.push((k.clone(), v.clone()))
        }
        new_vec
    }
}