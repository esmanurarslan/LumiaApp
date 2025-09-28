# Lumia - Film Uygulaması

<img width="500" height="500" alt="Lumia-logo" src="https://github.com/user-attachments/assets/2329415e-bd97-4a70-89e2-89bca83b5b3e" />
<br>
## Video Demo


https://github.com/user-attachments/assets/d8c9ab92-1ad2-44b2-b61b-d8c63c89271f



Bu proje, **Techcareer.net** tarafından düzenlenen iOS Developer Bootcamp'i kapsamında **Kasım Adalan** eğitmenliğinde geliştirilen bir bitirme projesidir. Uygulama, SwiftUI kullanılarak modern bir film satış platformu olarak tasarlanmıştır.

## ✨ Özellikler

Proje, bir film satış uygulamasının temel işlevlerini içermektedir

-  **Ana Sayfa:** Filmlerin listelenmesi ve kullanıcı arayüzünde sunulması
-  **Film Detay Sayfası:** Listeden seçilen bir filmin detaylarının (yönetmen, yıl, puan vb.) görüntülenmesi
-  **Adet Seçimi:** Detay sayfasında, sepete eklenecek film adedinin artırılıp azaltılabilmesi
-  **Sepete Ekleme:** Belirlenen adette filmin sepete eklenmesi
-  **Sepet Yönetimi:** Sepete eklenen tüm filmlerin bir arada görüntülenmesi
-  **Sepetten Silme:** İstenmeyen filmlerin sepetten tek tek kaldırılması
-  **Arama Özelliği:** Kullanıcılar filmlerin adı ve yönetmen bilgisine göre arayarak istedikleri filme daha hızlı ulaşabilmektedir


## 📱 Ekran Görüntüleri

Uygulamanın temel ekranlarına ait görseller aşağıdadır.

| Ana Sayfa                                       | Arama Ekranı                                      |
| ----------------------------------------------- | ------------------------------------------------- | 
|<img width="559" height="1062" alt="homepage" src="https://github.com/user-attachments/assets/6d1a140f-7d64-4778-86eb-79e9536dbb43" />| <img width="559" height="1062" alt="searchpage" src="https://github.com/user-attachments/assets/396a99aa-a9e0-4f30-b7bb-04a1f9d66cab" />
 

 Sepet Ekranı                                    | Film Detay                                        |
 ----------------------------------------------- | ------------------------------------------------- |
 |<img width="559" height="1062" alt="cartpage" src="https://github.com/user-attachments/assets/13ac13b6-627d-4382-8018-737c3f262353" />| <img width="559" height="1062" alt="detailpage" src="https://github.com/user-attachments/assets/3dfb593e-be3e-4d53-9f36-cfe88363f5eb" />
|
### Video Demo

## 🛠️ Kullanılan Teknolojiler ve Mimarî


https://github.com/user-attachments/assets/9ee67fc0-4f71-4c91-abcb-761d4d09dc7c


Proje, modern iOS geliştirme pratikleri göz önünde bulundurularak geliştirilmiştir.

-   **UI Framework:** SwiftUI
-   **Mimari:** MVVM (Model-View-ViewModel)
-   **Asenkron İşlemler:** Swift Concurrency (Async/Await)
-   **Network:** URLSession
-   **IDE:** Xcode

## 🌐 API Referansı

Proje, hazır bir web servisi üzerinden veri çekmektedir. Kullanılan endpoint'ler şunlardır:

| İşlev                  | Endpoint                                                 | Metot |
| ---------------------- | -------------------------------------------------------- | ----- |
| Tüm Filmleri Getir     | `http://kasimadalan.pe.hu/movies/getAllMovies.php`      | GET   |
| Sepete Film Ekle       | `http://kasimadalan.pe.hu/movies/insertMovie.php`   | POST  |
| Sepetteki Filmleri Getir | `http://kasimadalan.pe.hu/movies/getMovieCart.php`  | POST  |
| Sepetten Film Sil      | `http://kasimadalan.pe.hu/movies/deleteMovie.php`      | POST  |
| Film Resimleri         | `http://kasimadalan.pe.hu/movies/images/{resim_adi}.png`  | GET   |

## 🙏 Teşekkür

Bu projenin gelişim sürecindeki değerli eğitimleri ve rehberliği için **Kasım Adalan**'a ve bu fırsatı sunan **Techcareer.net**'e teşekkürler.

# Lumia - Movie App
<img width="500" height="500" alt="Lumia-logo" src="https://github.com/user-attachments/assets/2329415e-bd97-4a70-89e2-89bca83b5b3e" />
<br>

This is the final project developed for the iOS Developer Bootcamp organized by **Techcareer.net**, under the instruction of **Kasım Adalan** .The application is designed as a modern movie sales platform using SwiftUI.

## ✨ Features

The project includes the core functionalities of a movie sales application:

- **Homepage:** Lists all available movies.
- **Movie Detail Page:** Shows detailed information about a selected movie, such as director, year, and rating.
- **Quantity Selection:** Allows users to increase or decrease the number of items on the detail page.
- **Cart Management:** Displays all the movies currently in the cart.
- **Remove from Cart:** Allows for the removal of movies from the cart.
- **Search Feature:** Users can reach the movie they want faster by searching according to the name of the movies and director's information


## 📱 Screenshots

Below are the screenshots from the main screens of the application.

| Homepage                                | Search View                           | 
| --------------------------------------- | --------------------------------------- | 
|<img width="559" height="1062" alt="homepage" src="https://github.com/user-attachments/assets/6d1a140f-7d64-4778-86eb-79e9536dbb43" />| <img width="559" height="1062" alt="searchpage" src="https://github.com/user-attachments/assets/396a99aa-a9e0-4f30-b7bb-04a1f9d66cab" />
 

| Cart Page                                       | Movie Detail                                       |
| ----------------------------------------------- | ------------------------------------------------- |
|<img width="559" height="1062" alt="cartpage" src="https://github.com/user-attachments/assets/13ac13b6-627d-4382-8018-737c3f262353" />| <img width="559" height="1062" alt="detailpage" src="https://github.com/user-attachments/assets/3dfb593e-be3e-4d53-9f36-cfe88363f5eb" />


## 🛠️ Tech Stack & Architecture

The project was developed following modern iOS development practices.

-   **UI Framework:** SwiftUI
-   **Architecture:** MVVM (Model-View-ViewModel)
-   **Asynchronous Operations:** Swift Concurrency (Async/Await)
-   **Networking:** URLSession
-   **IDE:** Xcode

## 🌐 API Reference

The project fetches data from a remote web service. The endpoints used are as follows:

| Functionality          | Endpoint                                                 | Method |
| ---------------------- | -------------------------------------------------------- | ------ |
| Get All Movies         | `http://kasimadalan.pe.hu/movies/getAllMovies.php`       | GET    |
| Add Movie to Cart      | `http://kasimadalan.pe.hu/movies/insertMovie.php`      | POST   |
| Get Movies in Cart     | `http://kasimadalan.pe.hu/movies/getMovieCart.php`    | POST   |
| Delete Movie from Cart | `http://kasimadalan.pe.hu/movies/deleteMovie.php`       | POST   |
| Get Movie Images       | `http://kasimadalan.pe.hu/movies/images/{image_name}.png` | GET    |

## 🙏 Acknowledgements

Special thanks to our instructor **Kasım Adalan** for his valuable training and guidance throughout this project, and to **Techcareer.net** for providing this opportunity.
