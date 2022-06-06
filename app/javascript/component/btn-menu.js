const btnMenu = () => {
  const btnMenuBars = document.querySelector('.menu-btn')
  // const menuLinks = document.querySelectorAll('.menuLink')
  const openClose = document.querySelector('.btn-open-menu');
  const menu = document.querySelector('.menu')
  const lis = document.querySelectorAll('.menu li')

  if (btnMenuBars) {
    openClose.addEventListener('click', (event) => {
      console.log('coucou')
      menu.classList.toggle("active");
      openClose.classList.toggle("on");
    })
    lis.forEach(li => {
      li.addEventListener('click', (event) => {
        openClose.classList.remove("on");
      })
    });
  }
}

export { btnMenu };
