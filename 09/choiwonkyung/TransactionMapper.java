// 위치관련 
	List<RegionCodeDTO> findRegionsByAddress(@Param("address") String address);
	
	List<String> getDongListByGu(@Param("guName") String guName);
	
	String getGuByDong(@Param("dongName") String dongName);
