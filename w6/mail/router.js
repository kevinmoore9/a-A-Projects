class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    window.addEventListener("hashchange", () => {
      this.render();
    });
  }

  render() {
    this.node.innerHTML = "";
    let component = this.activeRoute();
    if (component) {
      // component.render();
      console.log(component);
      console.log(component.render());
      this.node.appendChild(component.render());
    }

    // let p = document.createElement("p");
    // p.innerHTML = component;
    // this.node.appendChild(p);
  }

  activeRoute() {
    let hash = window.location.hash.slice(1);
    let component = this.routes[hash];
    return component;
  }

}

module.exports = Router;
