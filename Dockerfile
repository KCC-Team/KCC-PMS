# 기본 이미지로 OpenJDK가 포함된 공식 Java 이미지를 사용
FROM openjdk:17

# 애플리케이션 파일을 컨테이너 내부에 복사하기 위한 작업 디렉토리 설정
WORKDIR /app

# Maven 빌드 시 생성된 JAR 파일을 Docker 이미지 내의 작업 디렉토리로 복사
# 'your-application.jar'는 실제 Maven 빌드 후 생성된 JAR 파일명으로 대체해야 함
COPY target/pms-0.0.1-SNAPSHOT.jar /app/

# 컨테이너가 시작될 때 실행될 명령어
# Java 애플리케이션 실행
CMD ["java", "-jar", "pms-0.0.1-SNAPSHOT.jar"]

# 컨테이너 내부에서 제공될 포트 번호 지정 (애플리케이션이 사용하는 포트)
EXPOSE 8080
