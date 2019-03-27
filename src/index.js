import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import './styles/main.pcss';

const app = Elm.Main.init({
  node: document.getElementById('root')
});

app.ports.hideOverflow.subscribe(() => {
	document.body.style.overflow = "hidden";
});

app.ports.showOverflow.subscribe(() => {
	document.body.style.overflow = "visible";
})

registerServiceWorker();
