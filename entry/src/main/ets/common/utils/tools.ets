export function formatTime(timeStr: string|undefined): string {
  if(!timeStr){
    return ''

  }
  const targetTime = new Date(timeStr).getTime();
  const currentTime = Date.now();
  const diff = currentTime - targetTime;
  if (diff <= 0) {
    return new Date(timeStr).toISOString().split('T')[0];
  }

  const hours = Math.floor(diff / 3600000);
  const days = Math.floor(diff / 86400000);
  const weeks = Math.floor(diff / 604800000);

  if (hours < 1) {
    return ' 刚刚 ';
  } else if (days < 1) {
    return `${hours}小时前`;
  } else if (weeks < 1) {
    return `${days}天前`;
  } else {
    return new Date(timeStr).toISOString().split('T')[0];
  }
}