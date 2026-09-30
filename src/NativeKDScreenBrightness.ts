import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  // Compteur de demandes : luminosité max au passage 0 -> 1, restaurée au passage 1 -> 0.
  requestMaxBrightness(): void;
  releaseMaxBrightness(): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('KDScreenBrightness');
