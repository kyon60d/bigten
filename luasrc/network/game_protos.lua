local GameProtos = {}

GameProtos["login"] = 
[[

message Msg {
  required string type = 1;
  required string data = 2;
}

message login_req {
  required string passport = 1;
  optional int32 serverid = 2;
  optional string ver1 = 3;
  optional string ver2 = 4;
}

message Player {
	optional int32 bak = 1;
	optional string icon = 2;
	optional string name = 3;
	optional int32 lev = 4;
	optional int32 vip = 5;
	optional int32 vitality = 6;	
	optional int32 maxvitality = 7;	
	optional int64 gold = 8;
	optional int32 diamond = 9;
	optional int32 bdiamond = 10;
	optional int32 exp = 11;
	optional int32 nextexp = 12;
	optional int64 time = 13;
	optional string manager = 14;
	optional int64 playerid = 15;
	optional string mname = 16;
	optional int32 vipe = 17;
	optional int64 gangid = 18;
	optional int32 fight = 19;
	optional int32 missionid = 20;
	optional int32 month = 21;
	optional int32 loginday = 22;
	optional int32 guide = 23;
	optional int32 paystatus = 24;
	optional int32 friendly = 25;
	optional string gang = 26;
	optional int32 gangBufferType = 27;
	optional int32 gangBufferLev = 28;
	optional int32 hcoin = 29;
	optional int32 topRank = 30;
	optional string sign = 31;
	optional string suggestid = 32;
	optional int32 rcoin = 33;
	optional string wbuffer = 34;
	optional string pbuffer = 35;
	optional int32 sex = 36;
	optional int64 createTime = 37;
	optional string payinfo = 38;
}


message Card {
	optional int32 cardid = 1;
	optional int64 playerid = 2;
	optional string name = 3;	
	optional int32 star = 4;
	optional int32 model = 5;
	optional int32 lev = 6;
	optional int32 exp = 7;
	optional int32 happy = 8;
	optional int32 fight = 9;
	optional int32 bind = 10;
	optional int32 mission = 11;
	optional int32 status = 12;
	optional int32 equip = 13;
	optional int32 item1 = 14;
	optional int32 item2 = 15;
	optional int32 item3 = 16;
	optional int32 item4 = 17;
	optional int32 sk1lev = 18;
	optional int32 sk2lev = 19;
	optional int32 sk3lev = 20;
	optional int32 sk4lev = 21;
	optional int32 skopen = 22;	
	optional SkinInfo modelInfo = 23;
	optional int32 iEq1lev = 24;
    optional int32 iEq2lev = 25;
    optional int32 iEq3lev = 26;
    optional int32 iEq4lev = 27;
    optional int32 tLev = 28;
    optional int32 tExp = 29;
    optional int32 tired = 30;
    optional int32 rock = 31;
    optional int32 pop = 32;
    optional int32 cla = 33;
    optional RoomInfo roomInfo = 34;
}

message SkinInfo {
	optional int32 cardid = 1;
	optional int32 skins = 2;
	repeated float property = 3;
	repeated int32 lev = 4;
}

message RoomInfo {
    optional int32 floor = 1;
    optional int32 luxury = 2;
}

message Item {
	optional int32 bagid = 1;	
	optional int32 itemid = 2;
	optional int32 num = 3;
}

message Equip {
	optional int32 iMcardid = 1;
	optional int32 itemid = 2;
	optional int32 adv = 3;
	optional int32 lev = 4;
	optional int32 bagid = 5;
	optional int32 num = 6;
}

message Ornament{
	optional int32 bagid = 1;	
	optional int32 itemid = 2;
	optional int32 used = 3;
	optional int32 floor = 4;
	optional int32 num = 5;
}

message Stage {
	optional int32 stageid = 1;
	repeated int32 levelid = 2;
	repeated int32 star = 3;
	optional int32 stageClaim = 4;	
	optional int32 stageEliteClaim = 5;
	repeated int32 hadChallenge = 6;
	repeated int32 buyNum = 7;
}

message PlayerTime {
	optional int32 arenaFightCount = 1;
	optional int32 meetCount = 2;
	optional int32 hadBoughtVitality = 3;	
	optional int32 hadBoughtSkillCount = 4;
	optional int32 hadRefreshedShopCount = 5;
	optional int32 hadRefreshedShop2Count = 6;
	optional int32 hadRefreshedShop3Count = 7;
	optional int32 hadRefreshedShop4Count = 8;	
	optional int32 hadExchangedCount = 9;
	optional int32 hadBoughtArenaCount = 10;
	optional int32 protect = 11;
	optional int32 hadAccelerateCount = 12;
	optional bool month_reward = 13;
	optional bool day7_reward = 14;
	optional int32 skillPoint = 15;
	optional int32 skillTime = 16;
	optional int32 arenaTime = 17;
	optional int32 flower = 18;
	optional int32 hadRefreshNotice = 19;
	optional bool month_reward_vip = 20;
	optional int32 activeBuffer = 21;
	optional int32 gangMateralShop = 22;
	optional int32 gangHappyShop = 23;
	optional int32 gangSignShop = 24;
	optional int32 vitalityTime = 25;
	optional int32 friendlyReward = 26;
	optional int32 lottery = 27;
	optional int32 firstLottery = 28;
	optional int32 hadRefreshedSingBarCount = 29;
	optional int32 hadBuyTeach = 30;
	repeated int32 cardTeach = 31;
	optional int32 teach = 32;
	optional int32 singbarCount = 33;
	optional int32 worldChatCount = 34;
	optional int32 singFightCount = 35;
	repeated int32 cardId = 36;
	repeated int32 cardInteract = 37;
	optional int32 lottery10 = 38;
}

message Result {
	optional int32 errorid = 1;
}

message login_resp{
	optional Result result = 1;
	optional Player player = 2;
	repeated Card card = 3;
	repeated Item item = 4;
	repeated Equip equip = 5;
	optional PlayerTime playerTime = 6;
	repeated Stage stages = 7;
	optional int64 curTime = 8;
	repeated Ornament ornament =9;
	optional int32 serverid = 10;
	optional string version = 11;
}

]]

return GameProtos
