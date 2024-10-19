import "./App.css";
import data from './data.json';

function App() {
  const openedLinks = new Set();

  const openRandomLink = () => {
    if (openedLinks.size === data.links.length) {
      openedLinks.clear();
    }

    let randomIndex;
    do {
      randomIndex = Math.floor(Math.random() * data.links.length);
    } while (openedLinks.has(data.links[randomIndex]));

    const randomLink = data.links[randomIndex];
    openedLinks.add(randomLink);
    window.open(randomLink, '_blank');
  };

  return (
    <>
      <div className="container">
        <button className="button" onClick={openRandomLink}>Click Me</button>
      </div>
    </>
  );
}

export default App;
