// 定义接口
interface AppUtils {
  getYsCompanyId: () => string;
  getYsUserId: () => string;
  getAppcode: () => string;
  getProductId: () => string;
}

// 导出时指定类型
const appUtils: AppUtils = {
  getYsCompanyId() {
    return 'D407CA0C210D49DF';
  },
  getYsUserId() {
    return '355595535695247D407CA0C210D49DF';
  },
  getAppcode() {
    return 'STGS';
  },
  getProductId() {
    return '063DD3A8567E4FEC8B11E66128D24764';
  }
};

export default appUtils;


// export default {
//   getYsCompanyId() {
//     return '';
//   },
//   getYsUserId() {
//     return '';
//   },
//   getAppcode() {
//     return '';
//   }
// } as {
//   getYsCompanyId: () => string;
//   getYsUserId: () => string;
//   getAppcode: () => string;
// };