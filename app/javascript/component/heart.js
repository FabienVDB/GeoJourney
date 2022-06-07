let favoriteElement = document.querySelector(".m-favorite");

favoriteElement.addEventListener("click",function(e){
   console.log(favoriteElement.className);
  if (favoriteElement.className.indexOf("-active") > -1) {
    favoriteElement.classList.remove("-active");
  } else {
    favoriteElement.classList.add("-active");
  }

},false);
export { heart };
