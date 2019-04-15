import { Elm } from "./Main.elm";
import registerServiceWorker from "./registerServiceWorker";
import "./styles/main.pcss";

// VERY naive
const PLATFORMS = {
	FIREFOX: /Firefox/,
	ANDROID: /Android/,
	APPLE: /Mac\sOS/,
	CHROME: /Chrome/,
	MOBILE: /Mobile/
};

const SOLID_COLORS = [ "#2a74d3", "#66c8c9", "#f5b941", "#9f2893"];
const CYCLE_COLORS = ["#051c3b", "#0038bb",...SOLID_COLORS];

const parseUserAgent = userAgent => {
	if (PLATFORMS.FIREFOX.test(userAgent)) {
		return "firefox";
	} else if (PLATFORMS.ANDROID.test(userAgent)) {
		return "android";
	} else if (PLATFORMS.MOBILE.test(userAgent) && PLATFORMS.APPLE.test(userAgent)) {
		return "ios";
	} else if (PLATFORMS.CHROME.test(userAgent)) {
		return "chrome";
	} else if (PLATFORMS.APPLE.test(userAgent)) {
		return "safari";
	}
};

const app = Elm.Main.init({
	node: document.getElementById("root"),
	flags: {
		platform: parseUserAgent(window.navigator.userAgent)
	}
});

let intervalId;


app.ports.cycleBg.subscribe(() => {
	clearInterval(intervalId);

	intervalId = setInterval(() => {
		setRandomBg(CYCLE_COLORS)
	}, 10000);
});

app.ports.solidBg.subscribe(() => {
	clearInterval(intervalId);

	setRandomBg(SOLID_COLORS)
})

app.ports.hideOverflow.subscribe(() => {
	lockBodyScroll(true);
});

app.ports.showOverflow.subscribe(() => {
	lockBodyScroll(false);
});


function lockBodyScroll(lock) {
	const tag = document.querySelector("main"); // the child element of body that contains the long content
	if (!tag) return;

	const elem = document.scrollingElement || document.body;

	if (lock) {
		const scrollTop = elem.scrollTop;
		tag.classList.add("no-scroll");
		tag.style.top = "-" + scrollTop + "px";
	} else {
		const top = tag.offsetTop;
		tag.classList.remove("no-scroll");
		tag.style.top = "0px";
		elem.scrollTop = -top;
	}
}

function setRandomBg(colors) {
	const index = Math.floor(Math.random() * Math.floor(colors.length));
	document.body.style.backgroundColor = colors[index];
}

registerServiceWorker();