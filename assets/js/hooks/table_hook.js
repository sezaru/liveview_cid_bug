const hasReachedTop = (element) => element.scrollTop <= 0;

const hideOrShowGoToTopButton = (goToTopButton, scrollContainer) => {
  if (hasReachedTop(scrollContainer)) {
    goToTopButton.classList.add('hidden');
  } else {
    goToTopButton.classList.remove('hidden');
  }
};

const scroll = (element, options) => element.scrollIntoView(options);

const TableHook = {
  mounted() {
    const goToTopButton = document.querySelector(
      '#' + this.el.id + '-go-to-top-button'
    );

    const bodyElement = this.el.querySelector('#' + this.el.id + '_body');

    // The event to check if new data needs to be fetched
    this.onScroll = (event) => {
      hideOrShowGoToTopButton(goToTopButton, this.el);
    };

    const onScrollToTop = (element) => {
      scroll(element, {
        behavior: 'smooth',
        block: 'start',
        inline: 'nearest',
      });
    };

    // The event to move table to the top
    this.onGoToTop = (event) => {
      const firstChild = bodyElement.firstElementChild;

      onScrollToTop(firstChild);
    };

    this.highlight = async (event) => {
      bodyElement
        .querySelectorAll('.bg-amber-100')
        .forEach((element) => element.classList.remove('bg-amber-100'));

      const row = bodyElement.querySelector('#transactions-' + event.id);
      row.classList.add('bg-amber-100');

      scroll(row, { behavior: 'smooth', block: 'center', inline: 'nearest' });
    };

    this.el.addEventListener('scroll', this.onScroll);

    this.el.addEventListener('go_to_top', this.onGoToTop);

    this.handleEvent('highlight-on-table', this.highlight);
  },

  destroyed() {
    this.el.removeEventListener('scroll', this.onScroll);

    this.el.removeEventListener('go_to_top', this.onGoToTop);
  },
};

export default TableHook;
