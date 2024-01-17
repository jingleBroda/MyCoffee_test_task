class CoffeeCanisterSet {
  final int canisterId;
  final String? extra;
  final String canisterName;
  final String canisterNameLang;
  final int materialId;
  final double time;
  final double? recipeTotal;
  final double recipeRemain;
  final double testResult;
  final int? isBIBCan;
  final String lastCleanTime;
  final int isShowed;
  final double testCurrent;
  final double lackRemain;
  final String? date;

  factory CoffeeCanisterSet.fromJson(Map<String, dynamic> json) {
    return CoffeeCanisterSet(
        canisterId:json['canisterId'],
        extra:json['extra'],
        canisterName:json['canisterName'],
        canisterNameLang:json['canisterNameLang'],
        materialId:json['materialId'],
        time:json['time'],
        recipeTotal:json['recipeTotal'],
        recipeRemain:json['recipeRemain'],
        testResult:json['testResult'],
        isBIBCan:json['isBIBCan'],
        lastCleanTime:json['lastCleanTime'],
        isShowed:json['isShowed'],
        testCurrent:json['testCurrent'],
        lackRemain:json['lackRemain'],
        date:json['date']
    );
  }

  factory CoffeeCanisterSet.empty() {
    return CoffeeCanisterSet(
        canisterId:-1,
        extra:null,
        canisterName:"empty",
        canisterNameLang:"",
        materialId:-1,
        time:0,
        recipeTotal:0,
        recipeRemain:0,
        testResult:0,
        isBIBCan:null,
        lastCleanTime:"",
        isShowed:0,
        testCurrent:0,
        lackRemain:0,
        date:""
    );
  }

  CoffeeCanisterSet({
    required this.canisterId,
    required this.extra,
    required this.canisterName,
    required this.canisterNameLang,
    required this.materialId,
    required this.time,
    required this.recipeTotal,
    required this.recipeRemain,
    required this.testResult,
    required this.isBIBCan,
    required this.lastCleanTime,
    required this.isShowed,
    required this.testCurrent,
    required this.lackRemain,
    required this.date,
  });
}