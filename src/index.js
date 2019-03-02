import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import './styles/main.pcss';

Elm.Main.init({
  node: document.getElementById('root')
});

registerServiceWorker();
