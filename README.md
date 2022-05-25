# MITM-IN-NTUT

## PART 1:arpspoof
### 測試環境
![image](https://user-images.githubusercontent.com/69759142/168472086-6418b2b9-c674-4736-94b6-8ace1e228e36.png)

1:Router

104:PC (Windows 10)

105:Notebook (Windows 10)

103:VM (Kali linux)

131:VM (CentOS 7)

### Script

![image](https://user-images.githubusercontent.com/69759142/168472356-4beb570f-59fb-4ecf-b2b4-1cf2bed2c8ae.png)

3~6行為判斷權限

8~11行為判斷參數數量是否正確

13為設定將封包進行轉發

15~18使用arpspoof進行攻擊並將Process ID記錄

23為結束PID1、PID2的Process

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
### Script
![image](https://user-images.githubusercontent.com/69759142/170325655-00694699-5293-4286-83b0-0bbc4052e367.png)


### 執行錯誤登入流程
![image](https://user-images.githubusercontent.com/69759142/170321044-85405c97-3d10-4ebb-b5ff-151f3b3b214b.png)

啟動Bash script

![image](https://user-images.githubusercontent.com/69759142/170322214-c7ddb5be-15b0-4af1-b2ac-d72427284b8f.png)

輸入錯誤帳號密碼

![image](https://user-images.githubusercontent.com/69759142/170322313-838871d4-ee03-4644-bd72-fe85831fe89e.png)

登入失敗

![image](https://user-images.githubusercontent.com/69759142/170322405-a9e12154-0c4a-4aa9-b183-81928cb6e12e.png)

script有獲得傳輸中的明文密碼

### 執行正常登入流程

![image](https://user-images.githubusercontent.com/69759142/170322667-954c988c-a166-44bf-90d2-9d1f31f5bf1a.png)

輸入正確帳號密碼

![image](https://user-images.githubusercontent.com/69759142/170322747-20bb2956-67a2-4de9-84a9-33e6d649dc8a.png)

登入成功畫面

![image](https://user-images.githubusercontent.com/69759142/170322858-9f5b6a65-1f8f-4d81-91e8-1b96e6a0e034.png)

script有獲得正確的傳輸中明文密碼



