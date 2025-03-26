// 定义 UserInfoResponse 类型
// export interface UserInfoResponse {
//   code: number;
//   message: string;
//   // 可以根据实际情况添加更多字段
// }

// 定义 底部菜单的返回 类型
export interface MenuInfoResponse {
  code: number;
  message: string;
  data: MenuInfoResponseData[];
}
export interface MenuInfoResponseData {
  chosedColor: string;
  chosedIcon: string;
  chosedIconType: number;
  chosedNav: ReadonlyArray<string>[];
  component: Component;
  currentVersion: number;
  currentVersionTime: string;
  currentVersionUser: string;
  customizeChosedIcon: string;
  customizeUnChosedIcon: string;
  menuId: string;
  name: string;
  order: number;
  productId: string;
  unChosedIcon: string;
  unChosedIconType: number;
  unChosedNav: ReadonlyArray<string>[];
}
interface Component {
  code: string;
  componentId: string;
  name: string;
  order: number;
}
//定义登录接口
// 定义 底部菜单的返回 类型
export interface UserInfoResponse {
  code: number;
  message: string;
  data: UserInfoResponseData;
}
export interface UserInfoResponseData {
  _id:string,
  thumbnail:string,
  name:string,
  sex:string,
  token:string,
  companyId:string,
}
// 请求params
interface requrstParams {
  companyId?: string;
  appCode?: string;
  userId?:string
}
// 登录请求body
export interface UserInfoRequestData {
  type:string,
  thirdPartyPlatform?:thirdPartyPlatform,
  phone?:string,
  mmMd5?:string,
}
// 三方登录
export interface thirdPartyPlatform {
  id:string,
  source:string,
  name:string,
  sex:string,
  iconurl:string
}
//定义首页栏目
// export interface ColumnInfoResponse {
//   data:innerColunmRespones
// }
// export interface innerColunmRespones {
//   code: number;
//   message: string;
//   data: ColumnInfoResponseData[];
// }


// export interface ColumnInfoResponseData {
//   id:string,
//   companyId:string,
//   outerUrl:string,
//   name:string,
//   isDel:string,
//   order:number,
//   isShow:string,
//   showType:number,
//   iconUrl:string,
//   backgroundImg:string,
// }
//
export interface ColumnInfoResponse {
  code: number;
  data: innerColunmRespones;
  message: string;
}

export interface innerColunmRespones {
  companyId: string;
  id: string;
  menuId: string;
  pageIds: string[];
  pages: Page[];
  productId: string;
  subscribeColumns: string[];
  userId: string;
}

export interface Page {
  circleId: string;
  companyId: string;
  isShow: string;
  name: string;
  navigationSrc: string;
  outerUrl: string;
  pageId: string;
  productId: string;
  remark: string;
  shoutVideoType: string;
  sourceType: string;
  titleType: string;
  type: string;
  version: number;
}
//查询app导航页面模块
export interface pageInfoResponse {
  code: number;
  data: pageData[];
  message: string;
}

interface pageData {
  _id: string;
  moduleName: string;
  index: number;
  type: string;
  src?: string;
  strategy?: string;
  showNumber?: number | string;
  docids?: string[];
  pageId: string;
  productId: string;
  companyId: string;
  srcSub?: string[];
  buttonMark?: string;
  queryMap?: QueryMap;
  imgUrl?: string;
  imgLink?: string;
}

interface QueryMap {
  showNumber: string;
  workMark: string;
}