import Conf from "conf";

export interface AppConfig {
  percent: number;
  rate: number;
  uiDelayMs: number;
}

const schema = {
  percent: {
    type: "number",
    minimum: 1,
    maximum: 99,
    default: 10,
  },
  rate: {
    type: "number",
    minimum: 0.001,
    default: 130,
  },
  uiDelayMs: {
    type: "number",
    minimum: 0,
    maximum: 5000,
    default: 50,
  },
} as const;

class ConfigManager {
  private config: Conf<AppConfig>;

  constructor() {
    this.config = new Conf<AppConfig>({
      projectName: "pgipte2",
      schema: schema as any,
      defaults: {
        percent: 10,
        rate: 130,
        uiDelayMs: 50,
      },
    });
  }

  getPercent(): number {
    return this.config.get("percent");
  }

  getRate(): number {
    return this.config.get("rate");
  }

  setPercent(value: number): void {
    if (value < 1 || value > 99) {
      throw new Error("Percentage must be between 1 and 99");
    }
    this.config.set("percent", value);
  }

  setRate(value: number): void {
    if (value <= 0) {
      throw new Error("Rate must be greater than 0");
    }
    this.config.set("rate", value);
  }

  getUiDelayMs(): number {
    return this.config.get("uiDelayMs");
  }

  setUiDelayMs(value: number): void {
    if (value < 0 || value > 5000) {
      throw new Error("UI delay must be between 0 and 5000 milliseconds");
    }
    this.config.set("uiDelayMs", value);
  }

  getAll(): AppConfig {
    return {
      percent: this.getPercent(),
      rate: this.getRate(),
      uiDelayMs: this.getUiDelayMs(),
    };
  }

  reset(): void {
    this.config.clear();
  }
}

export const configManager = new ConfigManager();
