from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
import time

# 크롬창(웹드라이버) 열기
s = Service('./chromedriver.exe')
driver = webdriver.Chrome(service=s)

# 구글 지도 접속하기
driver.get("https://www.google.com/maps/")



# 검색창에 "카페" 입력하기
searchbox = driver.find_element(By.CSS_SELECTOR,"input#searchboxinput")
searchbox.send_keys("카페")

# 검색버튼 누르기
searchbutton = driver.find_element(By.CSS_SELECTOR,"button#searchbox-searchbutton")
searchbutton.click()

# 여러 페이지(999)에서 반복하기
for i in range(999):
    # 시간 지연
    time.sleep(10)

    # 컨테이너(가게) 데이터 수집 // div.section-result-content
    stores = driver.find_elements(By.CSS_SELECTOR,"div.CpccDe")

    for s in stores:
        # 가게 이름 데이터 수집 // h3.section-result-title
        title = s.find_element(By.CSS_SELECTOR,"div.qBF1Pd.fontHeadlineSmall").text

        # 평점 데이터 수집 // span.cards-rating-score
        # 평점이 없는 경우 에러 처리
        try:
            score = s.find_element(By.CSS_SELECTOR,"span.MW4etd").text
        except:
            score = "평점없음"

       # 가게 댓글 수 수집 // span.section-result-location
        try:
            comment = s.find_element(By.CSS_SELECTOR,"span.UY7F9").text
        except:
            comment = "(0)"

        # 가게 주소 데이터 수집 // span.section-result-location
        addr = s.find_element(By.XPATH,"/html/body/div[3]/div[9]/div[9]/div/div/div[1]/div[2]/div/div[1]/div/div/div[2]/div[1]/div[7]/div/div/div[4]/div[1]/div/div/div[2]/div[4]/div[1]/span[2]/jsl/span[2]").text
        
        print(title, "/", score, "/", comment, "/", addr)

    # 다음페이지 버튼 클릭 하기
    # 다음페이지가 없는 경우(데이터 수집 완료) 에러 처리
    try:
        nextpage = driver.find_element(By.CSS_SELECTOR,"button#n7lv7yjyC35__section-pagination-button-next")
        nextpage.click()
    except:
        print("데이터 수집 완료.")
        break

# 크롬창 닫기
driver.close()
