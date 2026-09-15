enum SellerStatus {
  reliable,
  unreliable,
  stable;

  static valueOrDefault(String? value){
     switch(value?.toUpperCase()){
      case "RELIABLE": return reliable;
      case "UNRELIABLE": return unreliable;
      case "STABLE": return stable;
      default: return SellerStatus.stable;
    }
  }
}
