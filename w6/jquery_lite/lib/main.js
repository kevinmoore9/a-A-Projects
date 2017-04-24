window.$1 = arg => {
  if(typeof(arg) === "string") {
    Array.from(document.querySelectorAll(arg));
  } else if(typeof(arg) === "function") {

  } else if (typeof(arg) === "object") {

  }

};
