//package com.kcc.pms.init;
//
//import com.kcc.pms.auth.PrincipalDetailService;
//import com.kcc.pms.domain.member.model.vo.MemberVO;
//import com.kcc.pms.domain.member.service.MemberService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.boot.ApplicationArguments;
//import org.springframework.boot.ApplicationRunner;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.Profile;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.transaction.annotation.Transactional;
//
//import java.time.LocalDate;
//import java.util.Date;
//
//@Configuration
//@Transactional
//@Profile({"dev"})
//@RequiredArgsConstructor
//public class init implements ApplicationRunner {
//    private final MemberService memberService;
//    private final PrincipalDetailService principalDetailService;
//
//    @Override
//    public void run(ApplicationArguments args) throws Exception {
//        String name = "";
//        for (int i = 1; i < 4; i++) {
//            switch (i) {
//                case 1:
//                    name = "박길동";
//                    break;
//                case 2:
//                    name = "김길동";
//                    break;
//                case 3:
//                    name = "이길동";
//                    break;
//            }
//            MemberVO member = MemberVO.builder()
//                    .groupNumber(3)
//                    .id("pm" + i)
//                    .pw("123!")
//                    .memberName(name)
//                    .phoneNumber("010-1234-5678")
//                    .email("pm" + i + "@example.com")
//                    .authCode("PMS01503")
//                    .positionCode("PMS01702")
//                    .birthDate("1980-10-23")
//                    .techGradeCode("PMS01503")
//                    .organization("SI")
//                    .build();
//            memberService.saveMember(member);
//        }
//
//        for (int i = 14; i < 25; i++) {
//            MemberVO member = MemberVO.builder()
//                    .groupNumber(4)
//                    .id("user" + i)
//                    .pw("123!")
//                    .memberName("user" + i)
//                    .phoneNumber("010-1234-5678")
//                    .email("user" + i + "@example.com")
//                    .authCode("PMS01502")
//                    .positionCode("PMS01705")
//                    .birthDate("1980-10-23")
//                    .techGradeCode("PMS01502")
//                    .organization("SI")
//                    .build();
//            memberService.saveMember(member);
//        }
//
////        SecurityContextHolder.getContext().setAuthentication(
////                new UsernamePasswordAuthenticationToken(
////                        principalDetailService.loadUserByUsername("pm1"),
////                        null,
////                        principalDetailService.loadUserByUsername("pm1").getAuthorities()
////                )
////        );
//    }
//}
//
