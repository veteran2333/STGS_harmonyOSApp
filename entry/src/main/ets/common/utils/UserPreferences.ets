import { preferences } from '@kit.ArkData';
const name = 'userData'
class preferencesUtils{
  async get(key:string,value:preferences.ValueType){
    try{
      const context:Context=getContext(this)
      const preferences_obj = await preferences.getPreferences(context,name)
      const result = await preferences_obj.get(key,value)
      console.log('userData',`获取[${key}]成功`)
      return result
    }catch (e) {
      console.log('userData',`获取[${key}]失败`)
      return value
    }
  }
  async set(key:string,value:preferences.ValueType){
    try{
      const context:Context=getContext(this)
      const preferences_obj = await preferences.getPreferences(context,name)
      await preferences_obj.put(key,value)
      await preferences_obj.flush()
      console.log('userData',`存储[${key}]成功`)
    }catch (e) {
      console.log('userData',`存储[${key}]失败`)
    }
  }
  async delete(key:string){
    try{
      const context:Context=getContext(this)
      const preferences_obj = await preferences.getPreferences(context,name)
      await preferences_obj.delete(key)
      await preferences_obj.flush()
      console.log('userData',`删除[${key}]成功`)
    }catch (e) {
      console.log('userData',`删除[${key}]失败`)
    }
  }
}
export  default new preferencesUtils
