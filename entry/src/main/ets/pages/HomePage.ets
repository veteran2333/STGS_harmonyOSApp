
import { getSubscribeByMenuId,queryModules } from'../common/api/userApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import uinfo from '../common/utils/getUserInfo';
import { ColumnInfoResponse,Page,pageInfoResponse,pageDataType} from '../common/type/userType';
import { hilog } from '@kit.PerformanceAnalysisKit';
import  ModuleList from '../component/ModuleList'
// 定义 params 接口
interface Params {
  productId: string;
}

// 定义 data 接口
interface Data {
  companyId: string;
  userId: string;
  productId: string;
  menuId: string;
}

@Component
export default  struct HomePage {
  @State message: string = 'Hello World';
  @State columnData:Page[]=[]
  @State selectedIndex:number=0
  @State isLoading: boolean = true;
  // 默认菜单
  @Prop selectedMenuId: string = 'default';
  // 默认第一个菜单的第一个导航
  @State selectedPageId:string=''
  @State pageData:pageDataType[]=[]

  aboutToAppear(): void {
    this.getColumnData()
  }
  // 获取导航
  getColumnData(){
    let params:Params = {productId:uinfo.getProductId() }
    let data:Data  = {
      companyId:uinfo.getYsCompanyId(),
      userId:uinfo.getYsUserId(),
      productId:uinfo.getProductId(),
      menuId:this.selectedMenuId||'default',
    }
    getSubscribeByMenuId(params,data)
      .then((response: AxiosResponse<ColumnInfoResponse>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.columnData = data.data.pages
          this.selectedPageId = this.columnData[0].pageId
          this.getPageData(this.selectedPageId,uinfo.getProductId())
          this.isLoading = false;
          hilog.info(0x0000, '请求成功', '导航columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '导航columnData : %{public}s', JSON.stringify(this.columnData) ?? '');
        }
      })
      .catch((err: AxiosError<ColumnInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }

  // 获取导航内模块
  getPageData(pageId:string,productId:string){
    queryModules(pageId,productId)
      .then((response: AxiosResponse<pageInfoResponse>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.pageData = data.data
          hilog.info(0x0000, '请求成功', '模块列表pageData : %{public}s', JSON.stringify(this.pageData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '模块列表pageData : %{public}s', JSON.stringify(this.pageData) ?? '');
        }
      })
      .catch((err: AxiosError<pageInfoResponse>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
      Column(){
        if (this.isLoading) {
          LoadingProgress()
            .color(Color.Blue)
            .layoutWeight(1)
        } else {
          Scroll() { // 添加Scroll组件
            Tabs({barPosition:BarPosition.Start}){
              ForEach(this.columnData, (item: Page, index: number) => {
                TabContent(){
                  ModuleList({ modeLIstData: this.pageData,clickPageitem:item.name })
                }.tabBar(this.tabBuilder(index,item.name))
              },(item:Page) => item.circleId)
            }
            .onChange((Index:number)=>{
              this.selectedIndex = Index
              this.selectedPageId = this.columnData[Index].pageId
              this.getPageData(this.selectedPageId,uinfo.getProductId())
            })
            .width('100%') // 设置宽度为100%
            .scrollable(true) // 启用滚动
            .barMode(BarMode.Scrollable) // 设置滚动模式
            .barWidth('100%') // 设置bar宽度
          }
          .scrollable(ScrollDirection.Horizontal) // 设置水平滚动
        }
      }
    .height('100%')
    .width('100%')
  }
  @Builder
  tabBuilder(index: number, name: string) {
    Column(){
      Text(name)
        .fontSize(16)
        .fontColor(index === this.selectedIndex ? '#44999a' : '#666666') // 选中时蓝色，未选中时灰色
        .fontWeight(index === this.selectedIndex ? FontWeight.Bold : FontWeight.Normal) // 选中时加粗
    }
    .justifyContent(FlexAlign.Center)
    .padding(8)
  }
}
