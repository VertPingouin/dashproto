TestScene = {}

function TestScene:new(parent)
  local testScene = entity:new('testScene',{tags={'ticking'},parent=parent})

  testScene.te1 = test_entity:new('testScene',{r=255,g=0,b=0,layer=1,order=1,x=100,y=100,name='test1'}) --red
  testScene.te2 = test_entity:new('testScene',{r=0,g=255,b=0,layer=2,order=0,x=120,y=120,name='test2'}) --green
  testScene.te3 = test_entity:new('testScene',{r=0,g=0,b=255,layer=3,order=0,x=140,y=140,name='test3'}) --blue
  testScene.te4 = test_entity:new('test3',{r=0,g=255,b=255,layer=2,order=0,x=150,y=150,name='test4'}) --blue
  obm:remove('test3')

  obm:printChildren('root')
  obm:printVisible()
  function testScene:tick(dt)
  end

  return testScene
end

return TestScene
