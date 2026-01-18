export enum LogLevel {
  DEBUG = 0,
  INFO = 1,
  WARN = 2,
  ERROR = 3,
}

interface LogEntry {
  timestamp: string;
  level: string;
  requestId?: string;
  method?: string;
  url?: string;
  status?: number;
  durationMs?: number;
  error?: string;
  data?: Record<string, string | number | boolean | null>;
}

class LoggerService {
  private level: LogLevel = LogLevel.INFO;
  private static readonly MAX_LOGS = 100;
  private static readonly STORAGE_KEY = 'app_logs';

  constructor() {
    if (process.env.NODE_ENV === 'development') {
      this.level = LogLevel.DEBUG;
    }
  }

  private formatMessage(
    level: string,
    message: string,
    data?: Record<string, string | number | boolean | null>,
  ): string {
    const timestamp = new Date().toISOString();
    const logData = data ? JSON.stringify(data, null, 2) : '';
    return `[${timestamp}] [${level}] ${message} ${logData}`;
  }

  private saveToStorage(entry: LogEntry): void {
    if (typeof window === 'undefined') return;

    try {
      const logs = this.getStoredLogs();
      logs.push(entry);

      if (logs.length > LoggerService.MAX_LOGS) {
        logs.shift();
      }

      localStorage.setItem(LoggerService.STORAGE_KEY, JSON.stringify(logs));
    } catch {
      console.error('Failed to save logs to localStorage');
    }
  }

  private getStoredLogs(): LogEntry[] {
    if (typeof window === 'undefined') return [];

    try {
      const logs = localStorage.getItem(LoggerService.STORAGE_KEY);
      return logs ? JSON.parse(logs) : [];
    } catch {
      return [];
    }
  }

  private convertToLogData(obj: Record<string, unknown>): Record<string, string | number | boolean | null> {
    const result: Record<string, string | number | boolean | null> = {};

    for (const [key, value] of Object.entries(obj)) {
      const lowerKey = key.toLowerCase();
      if (lowerKey.includes('password') || lowerKey.includes('token')) {
        result[key] = '[REDACTED]';
      } else if (value === null || value === undefined) {
        result[key] = null;
      } else if (typeof value === 'string') {
        result[key] = value;
      } else if (typeof value === 'number') {
        result[key] = value;
      } else if (typeof value === 'boolean') {
        result[key] = value;
      } else {
        result[key] = String(value);
      }
    }

    return result;
  }

  debug(message: string, data?: Record<string, string | number | boolean | null>): void {
    if (this.level <= LogLevel.DEBUG) {
      console.debug(this.formatMessage('DEBUG', message, data));
    }
  }

  info(message: string, data?: Record<string, string | number | boolean | null>): void {
    if (this.level <= LogLevel.INFO) {
      console.info(this.formatMessage('INFO', message, data));
    }
  }

  warn(message: string, data?: Record<string, string | number | boolean | null>): void {
    if (this.level <= LogLevel.WARN) {
      console.warn(this.formatMessage('WARN', message, data));
    }
  }

  error(message: string, data?: Record<string, string | number | boolean | null>): void {
    if (this.level <= LogLevel.ERROR) {
      console.error(this.formatMessage('ERROR', message, data));
    }
  }

  logApiRequest<T extends object>(method: string, url: string, data?: T, requestId?: string): void {
    const entry: LogEntry = {
      timestamp: new Date().toISOString(),
      level: 'API_REQUEST',
      requestId,
      method,
      url,
      data: data ? this.convertToLogData(data as unknown as Record<string, unknown>) : undefined,
    };

    if (this.level <= LogLevel.DEBUG) {
      console.log(JSON.stringify(entry));
    }

    this.saveToStorage(entry);
  }

  logApiResponse<T extends object>(status: number, url: string, data?: T, requestId?: string): void {
    const entry: LogEntry = {
      timestamp: new Date().toISOString(),
      level: 'API_RESPONSE',
      requestId,
      method: undefined,
      url,
      status,
      data: data ? this.convertToLogData(data as unknown as Record<string, unknown>) : undefined,
    };

    if (this.level <= LogLevel.DEBUG) {
      console.log(JSON.stringify(entry));
    }

    this.saveToStorage(entry);
  }

  logApiError(status: number, url: string, error: Error | unknown, requestId?: string): void {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';
    const entry: LogEntry = {
      timestamp: new Date().toISOString(),
      level: 'API_ERROR',
      requestId,
      method: undefined,
      url,
      status,
      error: errorMessage,
    };

    if (this.level <= LogLevel.DEBUG) {
      console.log(JSON.stringify(entry));
    }

    this.saveToStorage(entry);
  }

  getLogs(): LogEntry[] {
    return this.getStoredLogs();
  }

  clearLogs(): void {
    if (typeof window !== 'undefined') {
      localStorage.removeItem(LoggerService.STORAGE_KEY);
    }
  }
}

export const logger = new LoggerService();
