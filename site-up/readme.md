Встановлюється Apache2:

![Screenshot 2024-02-23 141807.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+141807.png)

Створюється роль для AWS CLI:

![Screenshot 2024-02-23 161913.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+161913.png)

За допомогою bash скрипту, який запускається на інстансі через Terraform, встановлюється AWS CLI:

![Screenshot 2024-02-23 162246.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+162246.png)

Через Terraform інстанс запускається з роллю Terraform-EC2-UB03-S3. Він автоматично логіниться та отримує необхідні права (без ключів):

![Untitled](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Untitled+(7).png)

![Screenshot 2024-02-23 162518.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+162518.png)

![Untitled](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Untitled+(5).png)

Тепер за допомогою aws-cli можна завантажувати потрібні файли:

![Screenshot 2024-02-23 162725.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+162725.png)

![Untitled](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Untitled+(6).png)

При цьому файли в S3 не є публічними: 

![Screenshot 2024-02-23 163124.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+163124.png)

Далі завантажується папка через aws-cli (це робить bash скрипт):

![Screenshot 2024-02-23 163323.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+163323.png)

Готово:

![Screenshot 2024-02-23 163522.png](https://voutuk.s3.eu-north-1.amazonaws.com/public/homework2/Screenshot+2024-02-23+163522.png)
