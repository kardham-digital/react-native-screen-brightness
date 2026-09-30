/** Luminosité au max. Chaque appel doit être suivi d'un releaseMaxBrightness(). */
export declare function requestMaxBrightness(): void;
/** Restaure la luminosité d'origine quand plus aucun appel n'est en cours. */
export declare function releaseMaxBrightness(): void;

declare const _default: {
  requestMaxBrightness: typeof requestMaxBrightness;
  releaseMaxBrightness: typeof releaseMaxBrightness;
};
export default _default;
