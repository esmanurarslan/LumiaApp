
https://github.com/user-attachments/assets/4c8b1ec3-f84d-4066-b26d-02e8961e95d9
# Lumia - Film Uygulaması

<img width="500" height="500" alt="Lumia-logo" src="https://github.com/user-attachments/assets/2329415e-bd97-4a70-89e2-89bca83b5b3e" />
<br>

Bu proje, **Techcareer.net** tarafından düzenlenen iOS Developer Bootcamp'i kapsamında **Kasım Adalan** eğitmenliğinde geliştirilen bir bitirme projesidir. Uygulama, SwiftUI kullanılarak modern bir film satış platformu olarak tasarlanmıştır.

## ✨ Özellikler

Proje, bir film satış uygulamasının temel işlevlerini içermektedir

-  **Ana Sayfa:** Filmlerin listelenmesi ve kullanıcı arayüzünde sunulması
-  **Film Detay Sayfası:** Listeden seçilen bir filmin detaylarının (yönetmen, yıl, puan vb.) görüntülenmesi
-  **Adet Seçimi:** Detay sayfasında, sepete eklenecek film adedinin artırılıp azaltılabilmesi
-  **Sepete Ekleme:** Belirlenen adette filmin sepete eklenmesi
-  **Sepet Yönetimi:** Sepete eklenen tüm filmlerin bir arada görüntülenmesi
-  **Sepetten Silme:** İstenmeyen filmlerin sepetten tek tek kaldırılması


## 📱 Ekran Görüntüleri

Uygulamanın temel ekranlarına ait görseller aşağıdadır.

| Ana Sayfa                                       | Film Detay                                        | Sepet Ekranı                                    |
| ----------------------------------------------- | ------------------------------------------------- | ----------------------------------------------- |
| <img width="559" height="1062" alt="Home" src="https://github.com/user-attachments/assets/777ea136-ee2f-4192-b2aa-c63090d991c9" />| <img width="559" height="1062" alt="MovieDetail" src="https://github.com/user-attachments/assets/1b471e71-af13-4e9b-b496-34514aaedb51" /> | <img width="559" height="1062" alt="Cart" src="https://github.com/user-attachments/assets/dd97bd23-92ad-40c7-a34e-60515d253e29" /> |


### Video Demo

Uploading ScreenRecording_09-27-2025 17-22-02_1.MP4…
## 🛠️ Kullanılan Teknolojiler ve Mimarî

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


## 📱 Screenshots

Below are the screenshots from the main screens of the application.

| Homepage                                | Movie Detail                            | Shopping Cart                           |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| <img width="559" height="1062" alt="Home" src="https://github.com/user-attachments/assets/777ea136-ee2f-4192-b2aa-c63090d991c9" />| <img width="559" height="1062" alt="MovieDetail" src="https://github.com/user-attachments/assets/1b471e71-af13-4e9b-b496-34514aaedb51" /> | <img width="559" height="1062" alt="Cart" src="https://github.com/user-attachments/assets/dd97bd23-92ad-40c7-a34e-60515d253e29" /> |

### Video Demo

Uploading ScreenRecording_09-27-2025 17-22-02_1.MP4…
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
