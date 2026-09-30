import NativeKDScreenBrightness from './NativeKDScreenBrightness';

export const requestMaxBrightness = () => NativeKDScreenBrightness.requestMaxBrightness();
export const releaseMaxBrightness = () => NativeKDScreenBrightness.releaseMaxBrightness();

export default { requestMaxBrightness, releaseMaxBrightness };
