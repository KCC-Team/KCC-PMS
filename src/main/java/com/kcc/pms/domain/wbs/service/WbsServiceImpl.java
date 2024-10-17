package com.kcc.pms.domain.wbs.service;

import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.wbs.mapper.WbsMapper;
import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WbsServiceImpl implements WbsService {

    private final WbsMapper wbsMapper;

    @Override
    public int saveWbs(WbsRequestDto wbs) {
        int result = wbsMapper.saveWbs(wbs);

        if (result > 0
                && wbs.getMem_no() != null && !wbs.getMem_no().isEmpty()
                && wbs.getTm_no() != null && !wbs.getTm_no().isEmpty()) {
            return addMember(wbs);
        }

        return result;
    }

    @Override
    public List<WbsResponseDto> getWbsList(Long prj_no) {
        List<WbsResponseDto> wbsList = wbsMapper.getWbsList(prj_no);

        for (WbsResponseDto wbs : wbsList) {
            String preStartDate = wbs.getPre_st_dt();
            String preEndDate = wbs.getPre_end_dt();
            String startDate = wbs.getSt_dt();
            String endDate = wbs.getEnd_dt();
            if (preStartDate != null && preStartDate.length() >= 10) {
                wbs.setPre_st_dt(preStartDate.substring(0, 10));
            }
            if (preEndDate != null && preEndDate.length() >= 10) {
                wbs.setPre_end_dt(preEndDate.substring(0, 10));
            }
            if (startDate != null && startDate.length() >= 10) {
                wbs.setSt_dt(startDate.substring(0, 10));
            }
            if (endDate != null && endDate.length() >= 10) {
                wbs.setEnd_dt(endDate.substring(0, 10));
            }
        }

        return wbsList;
    }

    public int addMember(WbsRequestDto wbs) {
        String memNos = wbs.getMem_no();
        String tmNos = wbs.getTm_no();

        String[] memNoArray;
        String[] tmNoArray;

        if (memNos.contains(",")) {
            memNoArray = memNos.split(",");
        } else {
            memNoArray = new String[] { memNos };
        }

        if (tmNos.contains(",")) {
            tmNoArray = tmNos.split(",");
        } else {
            tmNoArray = new String[] { tmNos };
        }

        for (int i = 0; i < memNoArray.length; i++) {
            long memNo = Long.parseLong(memNoArray[i].trim());
            long tmNo = Long.parseLong(tmNoArray[i].trim());

            wbs.setMemNo(memNo);
            wbs.setTmNo(tmNo);

            int result = wbsMapper.saveWbsMember(wbs);
            if (result <= 0) {
                return result;
            }
        }

        return 1;
    }

}
