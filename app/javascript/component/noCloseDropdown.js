const noCloseDropdown = () => {
  const tagItems = document.querySelectorAll('.tag-item');

  if (tagItems) {
    tagItems.forEach(tagItem => {
      tagItem.addEventListener('click', (e) => {
        e.stopPropagation();
      });
    });
  }
}

export { noCloseDropdown };
