interface CacheEntry {
  value: unknown;
  timestamp: number;
  ttl: number;
}

class CacheService {
  private cache: Map<string, CacheEntry> = new Map();
  private static instance: CacheService;
  private static readonly STORAGE_KEY = 'app_cache';

  private constructor() {
    this.loadFromStorage();
  }

  static getInstance(): CacheService {
    if (!CacheService.instance) {
      CacheService.instance = new CacheService();
    }
    return CacheService.instance;
  }

  get<T>(key: string): T | null {
    const entry = this.cache.get(key);
    if (!entry) return null;

    const now = Date.now();
    const isExpired = now - entry.timestamp > entry.ttl;

    if (isExpired) {
      this.cache.delete(key);
      this.saveToStorage();
      return null;
    }

    return entry.value as T;
  }

  set<T>(key: string, value: T): void {
    const entry: CacheEntry = {
      value,
      timestamp: Date.now(),
      ttl: 15 * 60 * 1000,
    };
    this.cache.set(key, entry);
    this.saveToStorage();
  }

  remove(key: string): void {
    this.cache.delete(key);
    this.saveToStorage();
  }

  clear(): void {
    this.cache.clear();
    if (typeof window !== 'undefined') {
      localStorage.removeItem(CacheService.STORAGE_KEY);
    }
  }

  private loadFromStorage(): void {
    if (typeof window === 'undefined') return;
    try {
      const data = localStorage.getItem(CacheService.STORAGE_KEY);
      if (data) {
        const parsed = JSON.parse(data) as [string, CacheEntry][];
        this.cache = new Map(parsed);
      }
    } catch {}
  }

  private saveToStorage(): void {
    if (typeof window === 'undefined') return;
    try {
      localStorage.setItem(CacheService.STORAGE_KEY, JSON.stringify(Array.from(this.cache.entries())));
    } catch (error) {
      console.error('Failed to save cache to localStorage:', error);
    }
  }
}

export const cacheService = CacheService.getInstance();
