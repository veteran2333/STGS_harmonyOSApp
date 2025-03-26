// 导入 axios 及相关类型定义
import axios, { AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from './getUserInfo';
import { EnvConfig } from '../../env/dev'
import preferencesUtil from '../../common/utils/UserPreferences'

// 自定义assign方法
function assign(target: Record<string, Object>, ...source: Object[]): Record<string, Object> {
  for (const items of source) {
    for (const key of Object.keys(items)) {
      target[key] = Reflect.get(items, key)
    }
  }
  return target;
}
// 定义接口
interface PublicParams {
  companyId: string;
  userId: string;
  appCode: string;
  serviceCode: string;
}

// 定义一个通用的参数类型
type Params = Record<string, string | undefined>;


// 创建实例
export const axiosInstance: AxiosInstance = axios.create({
  baseURL: EnvConfig.apis.xyApi, // 请求基地址
  timeout: 1000 * 20 // 请求超时时间
});

// 添加请求拦截器
axiosInstance.interceptors.request.use(
  async(config: InternalAxiosRequestConfig) => {
    let publicParams: PublicParams = {
      companyId: uinfo.getYsCompanyId(),
      userId: uinfo.getYsUserId(),
      appCode: uinfo.getAppcode(),
      serviceCode: 'YUNSHI_XSGL',
    };

    // 将 publicParams 转换为 Params 类型
    config.params = assign({}, publicParams, config.params || {});
    // 初始化token
    config.headers['token']=await preferencesUtil.get('token','')
    console.log('请求头的token',config.headers['token'])
    // 在发送请求之前做些什么
    console.log('在发送请求之前做些什么', JSON.stringify(config));
    hilog.info(0x0000, '请求拦截', 'addAbilityMonitorCallback : %{public}s', JSON.stringify(config) ?? '');
    return config;
  },
  (error: Error) => {
    // 对请求错误做些什么
    console.error('对请求错误做点什么:', error);
    return Promise.reject(error);
  }
);

// 添加响应拦截器
axiosInstance.interceptors.response.use(
  (response: AxiosResponse) => {
    // 对响应数据做点什么
    console.log('对响应数据做点什么:', JSON.stringify(response));
    return response;
  },
  (error: Error) => {
    // 对响应错误做些什么
    console.error('对响应错误做点什么:', error);
    return Promise.reject(error);
  }
);