// // utils/EnvUtils.ts
//
// // 定义环境类型
// type EnvType = 'dev' | 'test' | 'prod';
//
// // 获取当前环境（默认为生产环境）
// const currentEnv: EnvType = (process.env.BUILD_ENV as EnvType) || 'prod';
//
// // 动态加载配置文件
// let EnvConfig: any;
// try {
//   EnvConfig = require(`../env/${currentEnv}`).EnvConfig;
// } catch (error) {
//   console.error('环境配置加载失败:', error);
//   // 回退到生产环境
//   EnvConfig = Require('../env/prod').EnvConfig;
// }
//
// export default EnvConfig;