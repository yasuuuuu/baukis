StaffMember.create!(
    email: 'taro@example.com',
    family_name: '山田',
    given_name: '太郎',
    family_name_kana: 'ヤマダ',
    given_name_kana: 'タロウ',
    password: 'password',
    start_date: Date.today
)

StaffMember.create!(
    email: 'yasu@example.com',
    family_name: '田中',
    given_name: '泰弘',
    family_name_kana: 'タナカ',
    given_name_kana: 'ヤスヒロ',
    password: 'password',
    start_date: Date.today,
    suspended: true
)
