# MITM-example

## PART 1:arpspoof
### 測試環境
![image](https://user-images.githubusercontent.com/69759142/168472086-6418b2b9-c674-4736-94b6-8ace1e228e36.png)

1:Router

104:PC (Windows 10)

105:Notebook (Windows 10)

103:VM (Kali linux)

131:VM (CentOS 7)

### Script

![image](https://user-images.githubusercontent.com/69759142/198824579-6451d386-2aa3-4c33-b848-24372953fc0a.png)

3~6行為判斷權限

8~11行為判斷參數數量是否正確

13為設定將封包進行轉發

14~15設定防火牆規則，將請求80PORT 443PORT的封包分別轉送到8080、8443

17~20使用arpspoof進行攻擊並將Process ID記錄

22啟動sslsplit進行中間人攻擊

29為結束PID1、PID2與PID3的Process

30刪除防火牆規則

### Normal condition
利用tcpdump發現在正常情況下區網內的其他電腦進行ping時其他電腦不會收到封包

![image](https://user-images.githubusercontent.com/69759142/168473357-84165ca4-9e56-4270-a395-b45f1fef7c75.png)


### Launch

![image](https://user-images.githubusercontent.com/69759142/168472437-6fe79ff5-0756-4aac-95fb-a3eac3964544.png)

在192.168.8.104的電腦開啟wireshark發現有大量的arp廣播

![image](https://user-images.githubusercontent.com/69759142/168472274-1787c042-c40e-4949-81b0-6960dbddb726.png)


查看104(PC)及131(CentOS 7)的ARP table發現104的ARP table裡router的MAC address被改為103(kali)的MAC address

![image](https://user-images.githubusercontent.com/69759142/168472965-ffcc5075-d9d8-4ad8-aec5-c6852139052a.png)
![image](https://user-images.githubusercontent.com/69759142/168473228-f8e1add1-019d-4d0f-9c5e-388ebc1dcfec.png)


再次執行ping並使用tcpdump發現封包流過kali

![image](https://user-images.githubusercontent.com/69759142/168473576-068214b1-0f7c-4fbf-8ba7-d91fdcf7548c.png)


## PART 2:MITM IN NTUT
### 利用openssl生成密鑰與憑照

openssl rsa -in ca.key -out ca.key.unsecure

openssl req -new x509 -keyout ca.key -out ca.crt

安裝ca.crt到受信任的跟憑證

### Script
![image](https://user-images.githubusercontent.com/69759142/170325655-00694699-5293-4286-83b0-0bbc4052e367.png)


### 執行錯誤登入流程
![image](https://user-images.githubusercontent.com/69759142/170321044-85405c97-3d10-4ebb-b5ff-151f3b3b214b.png)

啟動Bash script

![image](https://user-images.githubusercontent.com/69759142/170433822-cd1581f8-2cda-4e5c-8e0d-2f074696824b.png)

輸入錯誤帳號密碼

![image](https://user-images.githubusercontent.com/69759142/170322313-838871d4-ee03-4644-bd72-fe85831fe89e.png)

登入失敗

![image](https://user-images.githubusercontent.com/69759142/170322405-a9e12154-0c4a-4aa9-b183-81928cb6e12e.png)

script有獲得傳輸中的明文密碼

### 執行正常登入流程

![image](https://user-images.githubusercontent.com/69759142/170433902-ff75aada-93bf-417f-a8a0-ba85b8fc5041.png)

輸入正確帳號密碼

![image](https://user-images.githubusercontent.com/69759142/170433956-568d8fa5-8f34-4e89-a5e3-5a2e88a981a1.png)

登入成功畫面

![image](https://user-images.githubusercontent.com/69759142/170322858-9f5b6a65-1f8f-4d81-91e8-1b96e6a0e034.png)

script有獲得正確的傳輸中明文密碼

### 無法獲得明文密碼則使用ezblowfish encrypt&decrypt.txt內的工具
![image](https://user-images.githubusercontent.com/69759142/198824482-bd8318f2-1dc6-48e8-b418-34cc8b6ab3d2.png)
key為帳號
data為{ENCODE}後的內容
