import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd

    # Replace these variables with your desired food and area
    
def Google_data(food,area):
    nametemp="이름 없음"
    title_list=[]
    score_list=[]
    comment_list=[]
    address_list=[]
    phone_numlist=[]
    titlechecklist=[]
    # Configure your webdriver (replace with the path to your chromedriver)
    options = Options()
    options.add_experimental_option('excludeSwitches', ['--proxy-server'])
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')
    driver=webdriver.Chrome(executable_path=ChromeDriverManager().install(), options=options)
    #service = Service(ChromeDriverManager().install())
    #driver = webdriver.Chrome(service=service, options=options)
    #driver.maximize_window()

    # Open Google Maps
    driver.get("https://map.naver.com/v5/search")

    time.sleep(15)

    # Search for specific food in a specific area
    search_box = driver.find_element(By.CSS_SELECTOR,"div.input_box>input.input_search")
    search_box.send_keys(f"{area}의 {food}")
    search_box.send_keys(Keys.ENTER)
    for num in range(4):
    
        number_of_elements_found = 0

        time.sleep(5)
        
        # Switch to frame
        driver.switch_to.default_content();
        driver.switch_to.frame("searchIframe")

        wait = WebDriverWait(driver, 10)
        wait.until(EC.presence_of_element_located((By.CSS_SELECTOR, ".UEzoS")))

        time.sleep(5)

        # Scroll down the store name list
        scrollable_list = driver.find_element(By.CSS_SELECTOR, ".UEzoS")
        number_of_elements_found = 0

        while True:
            els = driver.find_elements(By.CSS_SELECTOR, '.UEzoS')
            if number_of_elements_found == len(els):
                print("데이터 스크롤 완료.")
                # Reached the end of loadable elements
                break

            try:
                driver.execute_script("arguments[0].scrollIntoView();", els[-1])
                time.sleep(2)
                number_of_elements_found = len(els)
                print(number_of_elements_found)

            except StaleElementReferenceException:
                # Possible to get a StaleElementReferenceException. Ignore it and retry.
                pass
            els = driver.find_elements(By.CSS_SELECTOR, '.UEzoS')

        # Wait for search results to load
        selector="span.TYaxT"
        wait = WebDriverWait(driver, 10)
        try:
            wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,selector)))
            # Get the list of restaurant elements
            restaurants = driver.find_elements(By.CSS_SELECTOR,selector)
        except:
            selector="span.TYaxT"
            wait.until(EC.presence_of_element_located((By.CSS_SELECTOR,selector)))
            restaurants = driver.find_elements(By.CSS_SELECTOR,selector)

        for restaurant in restaurants:
            error_occurred = True
            driver.execute_script("arguments[0].scrollIntoView();", restaurant)
            time.sleep(1)
            restaurant.click()
            time.sleep(2)
            soup = BeautifulSoup(driver.page_source, "html.parser")
            # Switch to default
            driver.switch_to.default_content();
            driver.switch_to.frame("entryIframe")
            
            # Extract rating
            try:
                rating = driver.find_element(By.XPATH, "//*[@id='app-root']/div/div/div/div[2]/div[1]/div[2]/span[1]/em").text
                print(rating)
                score_list.append(rating)
            except:
                rating = "평점없음"
                print(rating)
                score_list.append(rating)
            # Extract number of reviews
            try:
                if rating == "평점없음":
                    num_reviews = driver.find_element(By.XPATH, "//*[@id='app-root']/div/div/div/div[2]/div[1]/div[2]/span[1]/a/em").text
                else:
                    num_reviews = driver.find_element(By.XPATH, "//*[@id='app-root']/div/div/div/div[2]/div[1]/div[2]/span[2]/a/em").text
                print(num_reviews)
                comment_list.append(num_reviews)
            except:
                num_reviews = "(0)"
                print(num_reviews)
                comment_list.append(num_reviews)
                
            try:
                name = driver.find_element(By.XPATH, "//span[@class='Fc1rA']").text
                print(name)
                title_list.append(name)                
            except Exception as e:
                print(f"An exception occurred: {e}")
                error_occurred = True
                
            
                
            # Extract address
            try:
                address_element = driver.find_element(By.XPATH, "//span[@class='LDgIH']")
                address = address_element.text.strip()
                #address = soup.find("button", {"data-item-id": "address"}).get_text(strip=True)
                print(address)
                address_list.append(address)
            except:
                address="주소 없음"
                address_list.append(address)
                print(address)
            # Extract phone number
            try:
                phone_element = driver.find_element(By.XPATH, "//span[@class='xlx7Q']")
                phone = phone_element.text.strip()
                #phone = soup.find("button", {"data-tooltip": "전화번호 복사"}).get_text(strip=True)
                phone_numlist.append(phone)
                print(phone)
            except:
                phone="번호 없음"
                phone_numlist.append(phone)
                print(phone)

            driver.switch_to.default_content();
            driver.switch_to.frame("searchIframe")

        #click next page
        next_page = driver.find_element(By.XPATH,"//*[@id='app-root']/div/div[3]/div[2]/a[6]")
        next_page.click()
        time.sleep(7)
            

    df = pd.DataFrame({'Store':title_list,'keyword_food':'불고기','keyword_loc':'서울 홍대','naver_score':score_list,'comment':comment_list,'adderess':address_list,'phone_num':phone_numlist})

    # Close the driver
    driver.quit()
    return df

loc_list=['서울 홍대']
food_list=['불고기']

for loc in loc_list:
    for food in food_list:
        Google_data(food,loc).to_csv(loc+food+'.csv')
