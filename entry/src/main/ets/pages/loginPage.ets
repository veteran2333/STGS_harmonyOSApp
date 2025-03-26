import CryptoJS from '@ohos/crypto-js';
import { fanLoginByApp } from'../common/api/userApi'
import { UserInfoResponse,UserInfoResponseData,UserInfoRequestData} from '../common/type/userType';
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import preferencesUtil from '../common/utils/UserPreferences'
@Entry
@Component
struct LoginPage {
  @State message: string = '登录页面';
  @State phone: string = '18839858671';
  @State password: string = 'zxcasdqwe';
  @State verifyCode: string = '';
  @State isRegister: boolean = false;
  @State type:string='phoneLogin';
  @State userLoginData:UserInfoResponseData={
    _id:'',
    thumbnail:'',
    name:'',
    sex:'',
    token:'',
    companyId:'',
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('title')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 50 });

      // 手机号输入框
      TextInput({ placeholder: '请输入手机号' })
        .id('phoneInput')
        .type(InputType.Number)
        .onChange((value: string) => {
          this.phone = value;
        })
        .alignRules({
          top: { anchor: 'title', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 30 });

      // 密码输入框
      TextInput({ placeholder: '请输入密码' })
        .id('passwordInput')
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
        .alignRules({
          top: { anchor: 'phoneInput', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 20 });

      // 验证码输入框
      TextInput({ placeholder: '请输入验证码' })
        .id('verifyCodeInput')
        .type(InputType.Number)
        .onChange((value: string) => {
          this.verifyCode = value;
        })
        .alignRules({
          top: { anchor: 'passwordInput', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 20 });

      // 登录按钮
      Button('手机号密码登录')
        .id('loginButton')
        .onClick(() => {
          this.handleLogin();
        })
        .alignRules({
          top: { anchor: 'verifyCodeInput', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 30 });

      // 微信登录按钮
      Button('微信登录')
        .id('wechatLoginButton')
        .onClick(() => {
          this.handleWechatLogin();
        })
        .alignRules({
          top: { anchor: 'loginButton', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 20 });

      // 注册/登录切换按钮
      Button(this.isRegister ? '已有账号？去登录' : '没有账号？去注册')
        .id('toggleButton')
        .onClick(() => {
          this.isRegister = !this.isRegister;
          this.message = this.isRegister ? '注册页面' : '登录页面';
        })
        .alignRules({
          top: { anchor: 'wechatLoginButton', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .margin({ top: 20 });
    }
    .padding({top:0,left:20,right:20,bottom:0})
    .height('100%')
    .width('100%')
  }
  // 处理手机号密码登录
  private handleLogin() {
    // 这里添加登录逻辑
    let MD5Password = CryptoJS.MD5(this.password)
    console.log(`手机号: ${this.phone}, 密码: ${this.password},加密:${MD5Password}`);

    let data:UserInfoRequestData = {
      type:this.type,
      phone:this.phone,
      mmMd5:`${MD5Password}`
    }
    fanLoginByApp(data)
      .then(async (response: AxiosResponse<UserInfoResponse>) => {
        const data = response.data;
        if (data&&data.code===0) {
          hilog.info(0x0000, '请求成功', 'UserInfoResponse : %{public}s', JSON.stringify(data) ?? '');
          await preferencesUtil.set('userInfo',JSON.stringify(data.data))
          await preferencesUtil.set('token',data.data.token)
        } else {
          hilog.info(0x0000, '请求失败1', 'UserInfoResponse : %{public}s', JSON.stringify(data) ?? '');
        }
      })
      .catch((err: AxiosError<UserInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }

  // 处理微信登录
  private handleWechatLogin() {
    // 这里添加微信登录逻辑
    console.log('微信登录');
  }
}