import { axiosInstance } from '../utils/myHttps';
import { AxiosResponse } from '@ohos/axios';


// 引入 userType.ets 中的 UserInfoResponse 类型
import { UserInfoResponse,MenuInfoResponse,UserInfoRequestData,ColumnInfoResponse,pageInfoResponse} from '../../common/type/userType';

// 查询用户信息
export function getInfo(graphicCode: string): Promise<AxiosResponse<UserInfoResponse>> {
  // return axiosInstance({
  //   baseURL: '',
  //   url: 'get',
  //   method: 'get',
  //   params: { graphicCode }
  // });
  return axiosInstance({
    baseURL: 'http://shanhe.kim',
    url: '/api/za/chouq.php',
    method: 'get',
    params: {  }
  });
}
// 根据应用id查询菜单
export function queryMenusBaseInfoByProductId(productId:string,userId:string): Promise<AxiosResponse<MenuInfoResponse>> {
  return axiosInstance({
    url: '/api/xy/toc/v1/queryMenusBaseInfoByProductId',
    method: 'GET',
    params: {
      productId,
      userId
    }
  });
}
// 根据菜单id查询导航   <页面设置>查询APP已订阅的栏目getSubscribe
export function getSubscribeByMenuId(params:object,data:object): Promise<AxiosResponse<ColumnInfoResponse>> {
  return axiosInstance({
    url: '/api/xy/subscribe/v1/getSubscribe',
    method: 'POST',
    params,
    data
  });
}

// 登录接口
export function fanLoginByApp( data: UserInfoRequestData): Promise<AxiosResponse<UserInfoResponse>> {
  return axiosInstance({
    url: '/api/xy/fans/v4/fanLoginByApp',
    method: 'POST',
    data: data
  });
}
//查询app导航页面模块
export function queryModules(pageId:string,productId:string): Promise<AxiosResponse<pageInfoResponse>> {
  return axiosInstance({
    url: '/api/xy/toc/v1/queryModules',
    method: 'GET',
    params: {
      pageId,
      productId
    }
  });
}