let queue = [];

const Popover = options => {

};
Popover.close = () => {
    queue.forEach(popover => {
      popover.close();
    });
    queue = [];
};
Popover.add = (popover) => {
  queue.push(popover)
};

export default Popover;
