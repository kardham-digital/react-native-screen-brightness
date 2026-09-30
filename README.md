# @kardham-digital/react-native-screen-brightness

Force la luminosité de l'écran au maximum le temps d'afficher un contenu à scanner (QR code, badge), puis restaure la luminosité d'origine.

TurboModule (New Architecture uniquement), autolinké sur Android et iOS : rien à déclarer dans `MainApplication` ni dans le projet Xcode.

## Installation

```bash
yarn add github:kardham-digital/react-native-screen-brightness#v1.0.0
cd ios && pod install
```

Prérequis : React Native ≥ 0.76 avec `newArchEnabled=true`.

## Utilisation

Chaque `requestMaxBrightness()` doit être suivi d'un `releaseMaxBrightness()`. Le module compte les demandes : la luminosité monte au max à la première et n'est restaurée qu'à la dernière libération. Plusieurs écrans peuvent donc l'utiliser en même temps.

Exemple de hook :

```js
import { useEffect } from 'react';
import { requestMaxBrightness, releaseMaxBrightness } from '@kardham-digital/react-native-screen-brightness';

const useMaxBrightness = (active) => {
	useEffect(() => {
		if (!active) return;
		requestMaxBrightness();
		return () => releaseMaxBrightness();
	}, [active]);
};

// Dans l'écran qui affiche le QR code :
useMaxBrightness(isQrCodeVisible);
```

## Comportement par plateforme

- **Android** : la luminosité est forcée uniquement pour la fenêtre de l'app (`WindowManager.LayoutParams.screenBrightness`), sans permission. Hors de l'app, et à la restauration, le téléphone reprend son propre réglage, luminosité auto comprise.
- **iOS** : la luminosité (`UIScreen.brightness`) vaut pour tout le téléphone. Le module retient la valeur d'origine, la rend quand l'app passe en arrière-plan, et remet le max au retour si une demande est toujours en cours.
- **Simulateur iOS** : la luminosité n'y a aucun effet, le test doit se faire sur un vrai iPhone.

## Vérifier sur Android

```bash
adb shell dumpsys window windows | grep -o "sbrt=[0-9.]*"
```

`sbrt=1.0` quand la luminosité est forcée, aucune valeur sinon.

## Licence

MIT, voir [LICENSE](LICENSE).
