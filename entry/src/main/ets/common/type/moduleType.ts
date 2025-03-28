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
  pageNum: number;
  totalRecord: number;
  currentPage: number;
  totalPage: number;
  results: Result[];
}

export interface Result {
  docid: string;
  weight: number;
  moduleId: string;
  pageId: string;
  _id: string;
  imageCount: number;
  classify: string;
  showTotalPv: string;
  intime: string;
  srclink: string;
  departmentId: string;
  videos: Video[];
  source: string;
  title: string;
  userid: string;
  pushtime: string;
  isRelease: string;
  videoCount: number;
  companyid: string;
  vocabulary: string;
  docs: string[];
  articleType: number;
  audioCount: number;
  ctime: string;
  contentType: string;
  summary: string;
  thumbnail: string;
  images: Image[];
  isNewFabu: string;
  utime: string;
  author: string;
  zhuanti: Zhuanti[];
  mthId: string;
  showPublishTime: string;
  isNew: string;
  sourceDocId: string;
  srcType: number;
  special: string;
  audios: string[];
  extend1: string;
  cibiao: Cibiao[];
  taskId: string;
  status: number;
  isIndex: string;
  isChoise: string;
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