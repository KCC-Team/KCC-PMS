package com.kcc.pms.auth;

import com.kcc.pms.domain.member.mapper.MemberMapper;
import com.kcc.pms.domain.member.model.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PrincipalDetailService implements UserDetailsService {
    private final MemberMapper memberMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberVO member = memberMapper.findById(username);
        if (member != null) {
            return new PrincipalDetail(member);
        }
        return null;
    }
}
