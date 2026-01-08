import Conf from 'conf';

export interface AppConfig {
  percent: number;
  rate: number;
}

const schema = {
  percent: {
    type: 'number',
    minimum: 1,
    maximum: 99,
    default: 10
  },
  rate: {
    type: 'number',
    minimum: 0.001,
    default: 130
  }
} as const;

class ConfigManager {
  private config: Conf<AppConfig>;

  constructor() {
    this.config = new Conf<AppConfig>({
      projectName: 'pgipte2',
      schema: schema as any,
      defaults: {
        percent: 10,
        rate: 130
      }
    });
  }

  getPercent(): number {
    return this.config.get('percent');
  }

  getRate(): number {
    return this.config.get('rate');
  }

  setPercent(value: number): void {
    if (value < 1 || value > 99) {
      throw new Error('Percentage must be between 1 and 99');
    }
    this.config.set('percent', value);
  }

  setRate(value: number): void {
    if (value <= 0) {
      throw new Error('Rate must be greater than 0');
    }
    this.config.set('rate', value);
  }

  getAll(): AppConfig {
    return {
      percent: this.getPercent(),
      rate: this.getRate()
    };
  }

  reset(): void {
    this.config.clear();
  }
}

export const configManager = new ConfigManager();
