class MoneyStorage{
  double _money = 0.0;
  bool get(double needable){
    if(_money >= needable){
      _money -= needable;
      return true;
    }
    return false;
  }

  set money(double money) => _money += money;
}