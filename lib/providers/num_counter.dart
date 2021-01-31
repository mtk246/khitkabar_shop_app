class NumCounter {
  final int initNumber;
  final Function(int) counterCallBack;
  final Function increaseCallBack;
  final Function decreaseCallBack;

  NumCounter({
    this.initNumber,
    this.counterCallBack,
    this.increaseCallBack,
    this.decreaseCallBack,
  });
}
