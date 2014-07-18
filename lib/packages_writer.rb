class PackagesWriter

  # Store in DB (packages, versions, users)
  def self.store(packages_info)

    puts "Storing"
    packages_info.each do |package|
      create_package_info package
    end
  end

  private

  def self.create_package_info(package_info_hash)
    package = store_package(package_info_hash)
    version = store_version(package, package_info_hash)
    store_authors_and_maintainers(package_info_hash, version)
  end

  def self.store_authors_and_maintainers(package_info_hash, version)
    author_names = package_info_hash["Author"].split(/,| and /)
    maintainer_names = package_info_hash["Maintainer"].split(',')

    create_users(author_names, version, 'Author')
    create_users(maintainer_names, version, 'Maintainer')
  end

  def self.store_version(package, package_info_hash)
    version = Version.find_or_create_by(name: package_info_hash["Version"],
                                        package_id: package.id,
                                        publication_date: package_info_hash["Date/Publication"])
  end

  def self.store_package(package_info_hash)
    package = Package.find_or_create_by({name: package_info_hash["Package"],
                                         title: package_info_hash["Title"],
                                         publication_date: package_info_hash["Date/Publication"],
                                         description: package_info_hash["Description"],
                                        })
  end

  def self.create_users(names, version, user_type)
    names.each do |name|
      name, email = extract_user_name_and_email(name.strip)
      begin
        user = User.find_or_create_by(name: name, email: email)
        UserVersion.find_or_create_by(version_id: version.id, user_id: user.id, user_type: user_type)
      rescue => error
        Rails.logger.error "Failed to save #{name} - #{email}. #{error.message}"
      end
    end
  end

  def self.extract_user_name_and_email(user_details)
    name, email = user_details.scan(/([^<]*) <([^>]*)>/).first
    name ||= user_details

   return name, email
  end

end

