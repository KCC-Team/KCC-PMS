package com.kcc.pms.domain.wbs.service;

import com.kcc.pms.domain.project.model.dto.ProjectResponseDto;
import com.kcc.pms.domain.team.model.vo.Team;
import com.kcc.pms.domain.wbs.mapper.WbsMapper;
import com.kcc.pms.domain.wbs.model.dto.WbsRequestDto;
import com.kcc.pms.domain.wbs.model.dto.WbsResponseDto;
import com.kcc.pms.domain.wbs.model.vo.Wbs;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WbsServiceImpl implements WbsService {

    private final WbsMapper wbsMapper;

    @Override
    public int saveWbs(WbsRequestDto wbs) {
        Long maxOrderId = wbs.getMax_order_id();
        if(maxOrderId == null){
            wbs.setPar_task_no(0L);
            maxOrderId = 0L;
        } else {
            wbs.setPar_task_no(maxOrderId);
        }
        Integer maxOrderNo = wbsMapper.getMaxOrderNo(maxOrderId);
        if(maxOrderNo == null){
            maxOrderNo = 1;
        } else {
            maxOrderNo = maxOrderNo + 1;
        }
        wbs.setOrder_no(maxOrderNo);

        int result = wbsMapper.saveWbs(wbs);

        if (result > 0
                && wbs.getMem_no() != null && !wbs.getMem_no().isEmpty()
                && wbs.getTm_no() != null && !wbs.getTm_no().isEmpty()) {
            addMember(wbs);
        }

        if (result > 0
                && wbs.getFolder_no() != null && !wbs.getFolder_no().isEmpty()) {
            addOutput(wbs);
        }

        return result;
    }

    @Override
    public List<WbsResponseDto> getWbsList(Long prj_no, Long tsk_no) {
        List<WbsResponseDto> wbsList = wbsMapper.getWbsList(prj_no, tsk_no);

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

    @Override
    public List<WbsResponseDto> getTopTaskList(Long prjNo, Long tsk_no) {
        return wbsMapper.getTopTaskList(prjNo, tsk_no);
    }

    @Override
    public List<WbsResponseDto> getWbsOutputList(Long tsk_no) {
        return wbsMapper.getWbsOutputList(tsk_no);
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

    public int addOutput(WbsRequestDto wbs) {
        String folderNos = wbs.getFolder_no();

        String[] folderNoArray;

        if (folderNos.contains(",")) {
            folderNoArray = folderNos.split(",");
        } else {
            folderNoArray = new String[] { folderNos };
        }

        for (int i = 0; i < folderNoArray.length; i++) {
            long folderNo = Long.parseLong(folderNoArray[i].trim());

            wbs.setFolderNo(folderNo);

            int result = wbsMapper.saveWbsOutput(wbs);
            if (result <= 0) {
                return result;
            }
        }

        return 1;
    }


    @Override
    public void updateOrder(Integer wbsNo, Integer newParentNo, Integer newPosition) {
        Wbs movedWbs = wbsMapper.getWbsByNo(wbsNo);
        Integer oldParentId = movedWbs.getParentNo();

        List<Wbs> oldSiblings = wbsMapper.getSiblings(oldParentId);


        List<Wbs> newSiblings = wbsMapper.getSiblings(newParentNo);

        //부모가 동일한 경우 (같은 부모 하위에서 순서만 변경된 경우)
        if (oldParentId.equals(newParentNo)) {
            for (Wbs sibling : oldSiblings) {
                if (!sibling.getWbsNo().equals(wbsNo)) {
                    if (movedWbs.getOrderNo() < newPosition && sibling.getOrderNo() > movedWbs.getOrderNo() && sibling.getOrderNo() <= newPosition) {
                        sibling.setOrderNo(sibling.getOrderNo() - 1);  // 한 칸씩 당김
                        wbsMapper.updateWbsOrder(sibling.getWbsNo(), null, sibling.getOrderNo());
                    } else if (movedWbs.getOrderNo() > newPosition && sibling.getOrderNo() < movedWbs.getOrderNo() && sibling.getOrderNo() >= newPosition) {
                        sibling.setOrderNo(sibling.getOrderNo() + 1);  // 한 칸씩 밀어냄
                        wbsMapper.updateWbsOrder(sibling.getWbsNo(), null, sibling.getOrderNo());
                    }
                }
            }
        }
        //부모가 다른 경우 (부모가 변경된 경우)
        else {
            // 기존 부모의 형제들의 순서 변경
            for (Wbs sibling : oldSiblings) {
                if (sibling.getOrderNo() > movedWbs.getOrderNo()) {
                    sibling.setOrderNo(sibling.getOrderNo() - 1);
                    wbsMapper.updateWbsOrder(sibling.getWbsNo(), null, sibling.getOrderNo());
                }
            }

            // 새로운 부모의 형제들의 순서 변경
            for (Wbs sibling : newSiblings) {
                if (sibling.getOrderNo() >= newPosition) {
                    sibling.setOrderNo(sibling.getOrderNo() + 1);
                    wbsMapper.updateWbsOrder(sibling.getWbsNo(), null, sibling.getOrderNo());
                }
            }

            movedWbs.setParentNo(newParentNo);
        }

        movedWbs.setOrderNo(newPosition);

        wbsMapper.updateWbsOrder(movedWbs.getWbsNo(), newParentNo, newPosition);
    }

    @Override
    public int updateWbs(WbsRequestDto wbs) {
        int result = wbsMapper.updateWbs(wbs);
        if (result > 0
                && wbs.getMem_no() != null && !wbs.getMem_no().isEmpty()
                && wbs.getTm_no() != null && !wbs.getTm_no().isEmpty()) {
            wbsMapper.deleteWbsMember(wbs.getPrj_no(), wbs.getTsk_no());
            addMember(wbs);
        }
        if (result > 0
                && wbs.getFolder_no() != null && !wbs.getFolder_no().isEmpty()) {
            wbsMapper.deleteWbsOutput(wbs.getTsk_no());
            addOutput(wbs);
        }
        return result;
    }

    @Override
    public int deleteWbs(Long prj_no, Long tsk_no) {
        return wbsMapper.deleteWbs(prj_no, tsk_no);
    }

}
