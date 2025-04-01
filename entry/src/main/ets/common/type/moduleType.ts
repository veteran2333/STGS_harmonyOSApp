//新版轮播type
// export interface newSwiperItemType{
//   item:number,
//   name:string
// }
export interface newSwiperItemType {
  code: number;
  data: moduleId; // 移除泛型参数
  message: string;
}

// 使用映射对象类型代替泛型索引签名
export type moduleId = {
  [key: string]: moduleData;
};

export interface moduleData {
  code: number;
  src: string;
  moduleName: string;
  message: string;
  type: string;
  pageNum: number;
  docs: Docs;
  currentPage: number;
  strategy: string;
}

interface Docs {
  pageNum?: number;
  totalRecord?: number;
  currentPage?: number;
  totalPage?: number;
  results: Result[];
}

export interface Result {
  docid?: string;
  weight?: number;
  moduleId?: string;
  pageId?: string;
  _id?: string;
  imageCount?: number;
  classify?: string;
  showTotalPv?: string;
  intime?: string;
  srclink?: string;
  departmentId?: string;
  videos?: Video[];
  source?: string;
  title?: string;
  userid?: string;
  pushtime?: string;
  isRelease?: string;
  videoCount?: number;
  companyid?: string;
  vocabulary?: string;
  docs?: string[];
  articleType?: number;
  audioCount?: number;
  ctime?: string;
  contentType?: string;
  summary?: string;
  thumbnail?: string;
  images?: Image[];
  isNewFabu?: string;
  utime?: string;
  author?: string;
  zhuanti?: Zhuanti[];
  mthId?: string;
  showPublishTime?: string;
  isNew?: string;
  sourceDocId?: string;
  srcType?: number;
  special?: string;
  audios?: string[];
  extend1?: string;
  cibiao?: Cibiao[];
  taskId?: string;
  status?: number;
  isIndex?: string;
  isChoise?: string;
  liveRoomId?: string;
  liveStatus?: string;
  cuserType?: string;
  companyId?: string;
  appCode?: string;
  isDel?: string;
  cuserId?: string;
  roomName?: string;
  type?: string;
  lives?: liveList[];
  isOpen?: string;
  startTime?: string;
  endTime?: string;
  listImg?: string;
  listImgContainText?: string;
  viewSet?: ViewSet;
  commentConfig?: CommentConfig;
  menu?: string[];
  menuName?: string[];
  shareConfig?: ShareConfig;
  viewType?: string;
  liveTemplate?: string;
  isQuickReview?: string;
  template?: number;
  H5url?: string;
  disabledLive?: number;
  supportLive?: number;
  supportTime?: number;
  order?: number;
  ctimeStamp?: number;
  cuserName?: string;
  label?: Label[];
  wechatId?: string;
  checkStatus?: string;
  autoStart?: string;
  autoEnd?: string;
  companyName?: string;
  showBackwardTime?: string;
  isGenerateLookBack?: string;
  isTest?: string;
  masterCompanyCheckStatus?: string;
  uuserId?: string;
  uuserName?: string;
  checkUserName?: string;
  handledTimes?: number;
  openTimeShift?: string;
  liveStartTime?: number;
  duration?: number;
  liveEndTime?: number;
  lookBackIsDelete?: string;
  utimeStamp?: number;


  jibie?: string;
  servicecode?: string;
  appcode?: string;
  indexid?: string;
  subZhuanti?: string[];
  contentId?: string;
  src?: string;
  // 横板多图
  describe?: string;
  name?: string;
  specialType?: string;
  ispay?: number;
  thumbnailUrl?: string;
  thumbnailWidth?: number;
  thumbnailHeight?: number;
  cost?: number;
  outerUrl?: string;
  validityTime?: number;
  remark?: string;
  courseDescription?: string;
  introductionName?: string;
  listName?: string;
  personName?: string;
  personHead?: string;
  personBiography?: string;
  personDescription?: string;
  userName?: string;
  status_zh?: string;
  subSpecial?: SubSpecial[];
  // 瀑布流
  hasVoice?: number;
  authorThumbnail?: string;
  pv?: number;
  isFollow?: string;
  likeNum?: number;
  commentNum?: number;
  isPushUp?: string;

}

interface Cibiao {
  cbname: string;
  cbid: string;
}

interface Zhuanti {
  ztname: string;
  ztid: string;
}

interface Image {
  heightList: number;
  iurl: string;
  iurlList: string;
  width: string;
  itype: string;
  widthList: string;
  iname: string;
  height: number;
  describe?: string;
}

interface Video {
  duration: number;
  vpcurl: string;
  vname: string;
  vh5url: string;
  width: number;
  describe: string;
  vurl: string;
  vthumburl: string;
  height: number;
}

//大图列表（直播）

interface Label {
  labelId: string;
  labelName: string;
}

interface ShareConfig {
  commentDownLoad: boolean;
  desc: string;
  likeDownLoad: boolean;
  rewardDownLoad: boolean;
  thumbnail: string;
  title: string;
}

interface CommentConfig {
  robot: string;
  state: string;
}

interface ViewSet {
  autoTarget: number;
  linear: boolean;
  pvBase: number;
  pvShow: string;
  randomNum: number;
  randomShow: string;
  weight: boolean;
  weightStrategy: string;
}

export interface liveList {
  backUrl: string;
  channelId: string;
  channelUserId: string;
  ctime: string;
  duration: string;
  isBack: string;
  isQuickReview: string;
  name: string;
  pullStream: string;
  pushStream: string;
  stream: string;
  streamType: string;
  thumbnail: string;
  uuid: string;
  'isCompleted ': string;
}
//横板多图
interface SubSpecial {
  subId: string;
  subName: string;
}