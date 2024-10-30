package com.kcc.pms.domain.task.danger.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kcc.pms.auth.PrincipalDetail;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@NoArgsConstructor
@RequestMapping("/projects")
public class DangerController {

    @GetMapping("/dangers")
    public String danger(){
        return "danger/danger_list";
    }

    @GetMapping("/dangerInfo")
    public String dangerInfo(@AuthenticationPrincipal PrincipalDetail principalDetail, Model model) {
        MemberVO registerMember = principalDetail.getMember();
        ObjectMapper mapper = new ObjectMapper();
        String registerMemberJson = null;
        try {
            registerMemberJson = mapper.writeValueAsString(registerMember);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        model.addAttribute("registerMemberJson", registerMemberJson);
        return "danger/info";
    }
}
